
#sys_hist_file=$HISTFILE
HISTFILE=$FILENAME

#export HISTIGNORE="history\s+:"
#export HISTTIMEFORMAT="%F %T: "
#export HISTCONTROL=ignoredups:erasedups
#
#shopt -s histappend ## append, no clearouts
#shopt -s histverify ## edit a recalled history line before executing
#shopt -s histreedit ## reedit a history substitution line if it failed 

# https://www.gnu.org/software/bash/manual/bashref.html#index-history
# -r read from current history file
# -c clear memory
# -a append
user_prompt_cmd=$PROMPT_COMMAND
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

DATE=`date "+%F"`
TIME=`date "+%T"`

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

user_prompt=$PS1
PS1="(logit@\[\033[1;31m\]$base_name) \[\033[00m\]$PS1"
