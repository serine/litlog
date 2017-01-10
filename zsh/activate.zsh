
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

# load colours for prompt
autoload colors
colors

user_prompt=$PROMPT
PROMPT="(logit_env) $PROMPT"

_history_logger() {
  print -Sr -- "${1%%$'\n'}"
  fc -p $hist_file
}
#HISTORY_IGNORE="fc*|logit*"
# load hooks function
# for builtin functions -U flag is recomeneded
autoload -U add-zsh-hook
add-zsh-hook zshaddhistory _history_logger
