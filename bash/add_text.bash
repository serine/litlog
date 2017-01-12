add_note() {
  note="$1"
  if [[ ! -z $note ]]
  then
    echo "%> Note: $note" >> $litlog_notes_buffer
  fi
}
