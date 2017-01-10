# load colours for prompt
autoload colors
colors

DATE=`date "+%F"`
TIME=`date "+%T"`

# if length of the string is non-zero
#if [[ -n $FILENAME && -f $FILENAME ]]
#then

if [[ -f $FILENAME ]]
then
  # only append date string once a day
  if grep -q $DATE "$FILENAME"
  then
    echo "%>Another day at work yay ! $DATE $TIME" >> $FILENAME
  fi
else
  echo "%>Activated on $DATE at $TIME" > $FILENAME
  echo "%>Activated in $PWD" >> $FILENAME
  echo "%>Active file for logging $FILENAME" >> $FILENAME
fi

base_name=$(basename $FILENAME)

PROMPT="(logit@$base_name)%{${fg[green]}%}[%m]:%{$reset_color%}%2~%{$reset_color%}%# " 

_history_logger() {
  print -Sr -- "${1%%$'\n'}"
  fc -p $FILENAME
}
HISTORY_IGNORE="fc*|logit*"
# load hooks function
# for builtin functions -U flag is recomeneded
autoload -U add-zsh-hook
add-zsh-hook zshaddhistory _history_logger
