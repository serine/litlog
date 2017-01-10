#TODO think about how to append history back to a ~/.bash_history file
# if the user flags private then don't append on exit

logit_dir="$PWD/.logit"
text_file="$logit_dir/text.log"
hist_file="$logit_dir/history.log"

if [[ -d $logit_dir ]]
then
  echo "Detected an existing logit env, adding on to an existing env"
else
  mkdir $logit_dir
  touch $text_file $hist_file
fi

sys_histfile=$HISTFILE
export HISTFILE=$hist_file
# append existing history buffer to an old HISTFILE
history -a $sys_histfile
# clear history cache
history -c

user_histignore=$HISTIGNORE
user_histtimeformat=$HISTTIMEFORMAR
user_histcontrol=$HISTCONTROL

export HISTIGNORE="history\s+:echo\s%>*: $HISTIGNORE"
export HISTTIMEFORMAT="%F %T: "
export HISTCONTROL=ignoredups:erasedups
#
shopt -s histappend ## append, no clearouts
shopt -s histverify ## edit a recalled history line before executing
shopt -s histreedit ## reedit a history substitution line if it failed 

DATE=`date "+%F"`
TIME=`date "+%T"`

parent_dir=$(dirname $logit_dir)
base_name=$(basename $parent_dir)

if [[ -f $text_file ]]
then
  # only append date string once a day
  if grep -q $DATE "$text_file"
  then
    echo "%> Another day at work yay ! $DATE $TIME" >> $text_file
  else
    echo "%> logit_env activated on $DATE at $TIME" >> $text_file
    echo "%> logit_env activated in $parent_dir" >> $text_file
  fi
fi

# https://www.gnu.org/software/bash/manual/bashref.html#index-history
# -r read from current history file
# -c clear memory
# -a append
user_prompt_cmd=$PROMPT_COMMAND
export PROMPT_COMMAND="history -a; history -c; history -r;"

user_prompt=$PS1
#PS1="(logitenv@\[\033[1;31m\]$parent_dir\[\033[00m\]) $PS1"
#PS1="(\[\033[1;31m\]logit_env\[\033[00m\]) $PS1"
PS1="(logit_env) $PS1"

