
clear_cmd_buffer() {
  if [[ -e $litlog_cmd_buffer && -s $litlog_cmd_buffer ]]
  then
    rm $litlog_cmd_buffer
    touch $litlog_cmd_buffer
    echo "MESSAGE: clearing commands buffer"
  else
    echo "MESSAGE: Commands buffer is empty. Use --add commands to add commands"
  fi
}

clear_notes_buffer() {
  if [[ -e $litlog_notes_buffer && -s $litlog_notes_buffer ]]
  then
    rm $litlog_notes_buffer
    touch $litlog_notes_buffer
    echo "MESSAGE: clearing notes buffer"
  else
    echo "MESSAGE: Notes buffer is empty. Use --add notes to add notes"
  fi
}
