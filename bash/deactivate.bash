
echo "%> Deactivated on $DATE at $TIME" >> $litlog_log_file

#if [[ -z $private ]]
litlog_empty=""
if [[ -z $litlog_empty ]]
then
  #echo "This should be not a private sesison!"
  #echo "$private"
  cat $litlog_hist_file >> $sys_histfile 
else
  #echo "This should BE a private sesison!"
  #echo "$private"
  # append existing history buffer to env local history file
  history -a $HISTFILE
  # and clear the buffer
  history -c
fi

PS1=$user_prompt
PROMOT_COMMAND=$user_prompt_cmd
HISTFILE=$sys_histfile

HISTIGNORE=$user_histignore
HISTTIMEFORMAT=$user_histtimeformat
HISTCONTROL=$user_histcontrol

shopt -u histappend ## append, no clearouts
shopt -u histverify ## edit a recalled history line before executing
shopt -u histreedit ## reedit a history substitution line if it failed 

unset litlog_usr_env_dir
unset litlog_notes_buffer
unset litlog_hist_file
unset litlog_log_file

unset litlog_src_dir
# location of the lillog .litlog directory
unset litlog_env_path

unset litlog_hist_all
unset litlog_hist_buffer

unset title
unset note
unset private

