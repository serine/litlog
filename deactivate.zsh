
echo "%>Deactivated on $DATE at $TIME" >> $FILENAME
PROMPT="%{${fg[green]}%}[%m]:%{$reset_color%}%2~%{$reset_color%}%# " 
add-zsh-hook -d zshaddhistory _history_logger
unset HISTORY_IGNORE
unset FILENAME
