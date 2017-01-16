#TODO think about how to append history back to a ~/.bash_history file
# if the user flags private then don't append on exit

litlog_usr_env_dir="$litlog_env_path/.litlog"
litlog_notes_buffer="$litlog_usr_env_dir/notes_buffer.log"
litlog_hist_file="$litlog_usr_env_dir/history_file.log"

litlog_cmd_buffer="$litlog_usr_env_dir/cmd_buffer.log"
litlog_cmd_seen="$litlog_usr_env_dir/cmd_seen.log"

litlog_meta_buffer="$litlog_usr_env_dir/metadata_buffer.log"

litlog_log_file="$litlog_env_path/README.lit"

sys_histfile=$HISTFILE
export HISTFILE=$litlog_hist_file

#TODO should check for existens of all log/buffer files
# in case accidental deletion/curruption
if [[ -d $litlog_usr_env_dir ]]
then
  echo "MESSAGE: Detected an existing litlog env, adding on to an existing env"
  if [[ -e $litlog_hist_file && -s $litlog_hist_file ]]
  then
    history -r $litlog_hist_file
    echo "MESSAGE: Reading previous history file into memory"
  else
    echo "ERROR: This shouldn't have happened !"
  fi
else
  # append existing history buffer to an old HISTFILE
  history -a $sys_histfile
  # clear history cache for fresh litlog env
  history -c
  # make litlog directory for all its files
  mkdir $litlog_usr_env_dir
  # initiate empty files
  touch $litlog_notes_buffer \
        $litlog_hist_file \
        $litlog_meta_buffer 

  echo "MESSAGE: activating new litlog env"
fi

user_histignore=$HISTIGNORE
user_histtimeformat=$HISTTIMEFORMAR
user_histcontrol=$HISTCONTROL

export HISTIGNORE="history\s+:echo\s%>*: $HISTIGNORE"
export HISTTIMEFORMAT="%F %T: "
#export HISTCONTROL=ignoredups:erasedups
export HISTCONTROL=ignoredups:ignorespace
#
shopt -s histappend ## append, no clearouts
shopt -s histverify ## edit a recalled history line before executing
shopt -s histreedit ## reedit a history substitution line if it failed 

DATE=`date "+%F"`
TIME=`date "+%T"`

litlog_parent_dir=$(dirname $litlog_usr_env_dir)
base_name=$(basename $litlog_parent_dir)

if [[ -f $litlog_meta_buffer ]]
then
  # only append date string once a day
  if grep -q $DATE "$litlog_meta_buffer"
  then
    echo "%> Another day at work yay ! $DATE $TIME" >> $litlog_meta_buffer
    echo "" >> $litlog_meta_buffer 
  else
    echo "%> litlog_env activated on $DATE at $TIME" >> $litlog_meta_buffer
    echo "%> litlog_env activated in $litlog_parent_dir" >> $litlog_meta_buffer
    echo "" >> $litlog_meta_buffer 
  fi
else
  echo "ERROR: shouldn't have happened activate.bash !"
fi

# https://www.gnu.org/software/bash/manual/bashref.html#index-history
# -r read from current history file
# -c clear memory
# -a append
user_prompt_cmd=$PROMPT_COMMAND
export PROMPT_COMMAND=""

user_prompt=$PS1
PS1="(litlog_env) $PS1"
