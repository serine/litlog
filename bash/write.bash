
litlog_hist_all="$litlog_hist_file.all"
litlog_hist_buffer="$litlog_hist_file.buffer"

#write_hist_buffer() {
#  history > $litlog_hist_buffer
#}

write_hist() {
  history > $litlog_hist_buffer
  
  if [[ ! -e $litlog_hist_all ]]
  then
    touch $litlog_hist_all
  fi
  
  echo "\`\`\`" >> $litlog_log_file
  comm -3 <(cut -f 7- $litlog_hist_buffer -d" " | sort ) <(cut -f 7- $litlog_hist_all -d" " | sort) | grep -v "litlog*" >> $litlog_log_file
  echo "\`\`\`" >> $litlog_log_file
  
  cat $litlog_hist_buffer > $litlog_hist_all
}

if [[ -n $write_notes ]]
then
  echo "Writing out notes to $litlog_log_file"
  cat $litlog_notes_buffer >> $litlog_log_file
  echo "" >> $litlog_log_file
fi

if [[ -n $write_history ]]
then
  echo "Writing out history to $litlog_log_file"
  write_hist
fi

if [[ -n $write_all ]]
then
  echo "Writing out all to $litlog_log_file"
  cat $litlog_notes_buffer >> $litlog_log_file
  echo "" >> $litlog_log_file
  write_hist
fi

unset write_all
unset write_history
unset write_notes
