
DATE=`date "+%F"`

if [[ -f $FILENAME ]]
then
  # only append date string once a day
  if ! grep -q $DATE "$FILENAME"
  then
    echo "%>$DATE" >> $FILENAME
    echo "%>This is another day of work" >> $FILENAME
  fi
else
  echo "%>$DATE" > $FILENAME
  echo "%>$FILENAME was activated in $PWD" >> $FILENAME
fi

PROMPT="(logit-2-$FILENAME)%{${fg[green]}%}[%m]:%{$reset_color%}%2~%{$reset_color%}%# " 

_history_logger() {
  print -Sr -- "${1%%$'\n'}"
  fc -p $FILENAME
}
HISTORY_IGNORE="fc*|logit*"
# load hooks function
# for builtin functions -U flag is recomeneded
autoload -U add-zsh-hook
add-zsh-hook zshaddhistory _history_logger
