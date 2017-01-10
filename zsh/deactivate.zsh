
echo "%> Deactivated on $DATE at $TIME" >> $text_file

PROMPT=$user_prompt

add-zsh-hook -d zshaddhistory _history_logger
unset HISTORY_IGNORE
