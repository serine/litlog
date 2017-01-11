#TODO think about how to append history back to a ~/.bash_history file
# if the user flags private then don't append on exit

litlog_dir="$env_path/.litlog"
text_file="$litlog_dir/text.log"
hist_file="$litlog_dir/history.log"

litlog_origin=$(dirname $litlog_dir)
litlog_file="$litlog_origin/README.lit"

if [[ -d $litlog_dir ]]
then
  echo "Detected an existing litlog env, adding on to an existing env"
else
  mkdir $litlog_dir
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

parent_dir=$(dirname $litlog_dir)
base_name=$(basename $parent_dir)

if [[ -f $text_file ]]
then
  # only append date string once a day
  if grep -q $DATE "$text_file"
  then
    echo "%> Another day at work yay ! $DATE $TIME" >> $text_file
  else
    echo "%> litlog_env activated on $DATE at $TIME" >> $text_file
    echo "%> litlog_env activated in $parent_dir" >> $text_file
  fi
fi

# https://www.gnu.org/software/bash/manual/bashref.html#index-history
# -r read from current history file
# -c clear memory
# -a append
user_prompt_cmd=$PROMPT_COMMAND
export PROMPT_COMMAND="history -a; history -c; history -r;"

user_prompt=$PS1
#PS1="(litlogenv@\[\033[1;31m\]$parent_dir\[\033[00m\]) $PS1"
#PS1="(\[\033[1;31m\]litlog_env\[\033[00m\]) $PS1"
PS1="(litlog_env) $PS1"

