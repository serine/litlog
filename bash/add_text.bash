add_note() {
  note="$1"
  if [[ -n $note ]]
  then
    #echo "%> Note: $note" >> $litlog_notes_buffer
    echo "$note" >> $litlog_notes_buffer
    echo "" >> $litlog_notes_buffer
  fi
}
