
hist_all="$hist_file.all"
hist_buffer="$hist_file.buffer"

write_hist() {
  history > $hist_buffer
  
  if [[ ! -e $hist_all ]]
  then
    touch $hist_all
  fi
  
  echo "\`\`\`" >> $litlog_file
  comm -3 <(cut -f 7- $hist_buffer -d" " | sort ) <(cut -f 7- $hist_all -d" " | sort) | grep -v "litlog*" >> $litlog_file
  echo "\`\`\`" >> $litlog_file
  
  cat $hist_buffer > $hist_all
}

if [[ -n $write_notes ]]
then
  echo "Writing out notes to $litlog_file"
  cat $text_file >> $litlog_file
  echo "" >> $litlog_file
fi

if [[ -n $write_history ]]
then
  echo "Writing out history to $litlog_file"
  write_hist
fi

if [[ -n $write_all ]]
then
  echo "Writing out all to $litlog_file"
  cat $text_file >> $litlog_file
  echo "" >> $litlog_file
  write_hist
fi

unset write_all
unset write_history
unset write_notes

unset hist_all
unset hist_buffer
