
show_cmd() {
  if [[ -n $litlog_cmd_buffer ]]
  then
    if [[ ! -e $litlog_cmd_buffer ]]
    then
      echo "MESSAGE: Commands buffer is empty. Use --add to add commands"
    else
      cat $litlog_cmd_buffer
    fi
  else
    echo "ERROR: You are not in litlog env -> $litlog_env_path. use litlog activate to start one"
  fi
}

show_notes() {
  if [[ -n $litlog_notes_buffer ]]
  then
    if [[ ! -e $litlog_notes_buffer ]]
    then
      echo "MESSAGE: Notes buffer is empty. Use --add to add commands"
    else
      cat $litlog_notes_buffer
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
