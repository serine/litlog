
hist_all="$hist_file.all"
hist_buffer="$hist_file.buffer"

#cat $text_file >> $out_file
echo "" >> $out_file

history > $hist_buffer

if [[ ! -e $hist_all ]]
then
  touch $hist_all
fi

echo "\`\`\`" >> $out_file
comm -3 <(cut -f 7- $hist_buffer -d" " | sort ) <(cut -f 7- $hist_all -d" " | sort) | grep -v "logit*" >> $out_file
echo "\`\`\`" >> $out_file

cat $hist_buffer > $hist_all
