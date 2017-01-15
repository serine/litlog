
litlog_cmd_tmp="$litlog_usr_env_dir/litlog_cmd_tmp"

add_top_hist() {
  cmd_input="$1"
  hist_number="${cmd_input:1}"
  history | \
    head -n $hist_number | \
    sed -e 's/^[[:space:]]*//' | \
    cut -f 2- -d" " | \
    sed -e 's/^[[:space:]]*//' >> $litlog_cmd_buffer
  echo "MESSAGE: Adding command(s) to buffer"
}

add_bottom_hist() {
  cmd_input="$1"
  hist_number="${cmd_input:1}"
  history | \
    tail -n $hist_number | \
    sed -e 's/^[[:space:]]*//' | \
    cut -f 2- -d" " | \
    sed -e 's/^[[:space:]]*//' >> $litlog_cmd_buffer
  echo "MESSAGE: Adding command(s) to buffer"
}

add_range_hist() {
  cmd_input="$1"
  # get everything before the dash
  cmd_before="${cmd_input%%-*}"
  # get everything after the dash
  cmd_after="${cmd_input##*-}"
  if [[ $cmd_after -lt $cmd_before ]]
  then
    echo "ERROR: give correct range"
    break
  fi
  cmd_start="$(($cmd_after-cmd_before+1))"
  history | \
    head -n $cmd_after | \
    tail -n $cmd_start | \
    sed -e 's/^[[:space:]]*//' | \
    cut -f 2- -d" " | \
    sed -e 's/^[[:space:]]*//' >> $litlog_cmd_buffer
  echo "MESSAGE: Adding command(s) to buffer"
}

add_given_hist() {

  cmd_input="$1"
  #cmd_input=$((cmd_input+1))

  history | \
    sed -e 's/^[[:space:]]*//' | \
    grep "^$cmd_input " | \
    cut -f 2- -d" " | \
    sed -e 's/^[[:space:]]*//' >> $litlog_cmd_buffer
  echo "MESSAGE: Adding command(s) to buffer"
}

add_nodups_hist() {
  if [[ ! -e $litlog_cmd_buffer ]]
  then
    touch $litlog_cmd_seen
  fi
  #comm -3 <(cut -f 7- $litlog_hist_buffer -d" " | sort ) <(cut -f 7- $litlog_hist_all -d" " | sort) | grep -v "litlog*" >> $litlog_cmd_buffer
  comm -3 <(history | \
            sed -e 's/^[[:space:]]*//' | \
            cut -f 2- -d" " | \
            sed -e 's/^[[:space:]]*//' | \
            sort) \
          <(sort $litlog_cmd_seen) > $litlog_cmd_tmp
         #<(cut -f 2- $litlog_cmd_buffer -d" " | \
         #  sed -e 's/^[[:space:]]*//' | \
         #  sort) > $litlog_cmd_tmp

  #cat $litlog_cmd_tmp >> $litlog_cmd_buffer
  cat $litlog_cmd_tmp | \
    sed -e 's/^[[:space:]]*//' | \
    grep -v "litlog*" >> $litlog_cmd_buffer
  echo "MESSAGE: Adding ALL! command(s) to buffer"
  # move buffering command to seen
  cat $litlog_cmd_buffer >> $litlog_cmd_seen 
  rm $litlog_cmd_tmp
}

add_list_hist() {
  cmd_input=$1
  # convert commas to space
  get_cmd_str="${cmd_input//,/ }"
  # conver string to array
  cmd_array=($get_cmd_str)
  
  for i in ${cmd_array[@]}
  do
    add_given_hist $i
  done
}
