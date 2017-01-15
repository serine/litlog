
write_notes() {
  cat $litlog_notes_buffer >> $litlog_log_file
  echo "Writing out notes to $litlog_log_file"
  rm $litlog_notes_buffer
  touch $litlog_notes_buffer
}

write_cmd() {
  echo "\`\`\`" >> $litlog_log_file
  cat $litlog_cmd_buffer >> $litlog_log_file
  echo "\`\`\`" >> $litlog_log_file
  echo "Writing out commands to $litlog_log_file"
  rm $litlog_cmd_buffer
  touch $litlog_cmd_buffer
}

#write_metadata() {
#  cat $litlog_meta_buffer >> $litlog_log_file 
#}
