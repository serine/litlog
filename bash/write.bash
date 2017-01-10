echo "%> Your notes" >> $out_file
cat $text_file >> $out_file
echo "" >> $out_file

echo "%> History info so far" >> $out_file
history >> $out_file
echo "" >> $out_file
