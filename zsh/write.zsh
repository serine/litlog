
hist_all="$hist_file.all"
hist_buffer="$hist_file.buffer"

write_hist() {
  fc -lED > $hist_buffer
  
  if [[ ! -e $hist_all ]]
  then
    touch $hist_all
  fi
  
  echo "\`\`\`" >> $out_file
  comm -3 <(cut -f 5- $hist_buffer -d" " | sort ) <(cut -f 5- $hist_all -d" " | sort) | grep -v "logit*" >> $out_file
  echo "\`\`\`" >> $out_file
  
  cat $hist_buffer > $hist_all
}

if [[ -n $write_notes ]]
then
  echo "Writing out notes $write_notes"
  cat $text_file >> $out_file
  echo "" >> $out_file
fi

if [[ -n $write_history ]]
then
  echo "Writing out history $write_history"
  write_hist
fi
if [[ -n $write_all ]]
then
  echo "Writing out all $write_all"
  cat $text_file >> $out_file
  echo "" >> $out_file
  write_hist
fi

unset write_all
unset write_history
unset write_notes
