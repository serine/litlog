
show_cmd() {
  if [[ -n $litlog_cmd_buffer ]]
  then
    # file exists and not zero size
    if [[ -e $litlog_cmd_buffer && -s $litlog_cmd_buffer ]]
    then
      cat $litlog_cmd_buffer
    else
      echo "MESSAGE: Commands buffer is empty. Use --add to add commands"
    fi
  else
    echo "ERROR: You are not in litlog env -> $litlog_env_path. use litlog activate to start one"
  fi
}

show_notes() {
  if [[ -n $litlog_notes_buffer ]]
  then
    if [[ -e $litlog_notes_buffer && -s $litlog_notes_buffer ]]
    then
      cat $litlog_notes_buffer
    else
      echo "MESSAGE: Notes buffer is empty. Use --add to add commands"
    fi
  else
    echo "ERROR: You are not in litlog env -> $litlog_env_path. use litlog activate to start one"
  fi
}

show_location() {
  if [[ -n $litlog_parent_dir ]]
  then
    echo $litlog_parent_dir
  else
    echo "ERROR: You are not in litlog env -> $litlog_env_path. use litlog activate to start one"
  fi
}

show_metadata() {
  if [[ -n $litlog_meta_buffer ]]
  then
    cat $litlog_meta_buffer
  else
    echo "ERROR: You are not in litlog env -> $litlog_env_path. use litlog activate to start one"
  fi
}
