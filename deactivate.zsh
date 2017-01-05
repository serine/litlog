
PROMPT="%{${fg[green]}%}[%m]:%{$reset_color%}%2~%{$reset_color%}%# " 
add-zsh-hook -d zshaddhistory _per-directory-history-addhistory
unset HISTORY_IGNORE
unset FILENAME
