# up on deactivation you want
# 1. unset all of your litlog special vairable

# make sure meta_buffer file exist and log file string is set
if [[ -f $litlog_meta_buffer && -n $litlog_log_file ]]
then
  echo "%> Deactivated on $DATE at $TIME" >> $litlog_meta_buffer 
  echo "--------------------------------------------------------------------------------" >> $litlog_meta_buffer 
  echo "MESSAGE: deactivating litlog env $litlog_usr_env_dir"
  cat "$litlog_meta_buffer" >> $litlog_log_file
else
  echo "ERROR: shouldn't have happened deactivate.bash !"
fi

# shell will only write history on exit
if [[ -e $litlog_hist_file ]]
then
  # append history buffer to users global HISTFILE
  #history -a $sys_histfile
  # append history buffer to litlog local HISTFILE
  history -a $litlog_hist_file 
  # clear litlog buffer
  history -c 
  # off set users global history
  history -r $sys_histfile
  #cat $litlog_hist_file >> $sys_histfile 
else
  echo "MESSAGE: history file is empty. This shouldn't usually come up.."
fi

PS1=$user_prompt
unset user_prompt
PROMOT_COMMAND=$user_prompt_cmd
unset user_prompt_cmd

HISTFILE=$sys_histfile
unset sys_histfile
HISTIGNORE=$user_histignore
unset user_histignore 
HISTTIMEFORMAT=$user_histtimeformat
unset user_histtimeformat
HISTCONTROL=$user_histcontrol
unset user_histcontrol

shopt -u histappend ## append, no clearouts
shopt -u histverify ## edit a recalled history line before executing
shopt -u histreedit ## reedit a history substitution line if it failed 

unset litlog_usr_env_dir
unset litlog_notes_buffer
unset litlog_hist_file
unset litlog_log_file

unset litlog_cmd_buffer
unset litlog_cmd_tmp
unset litlog_cmd_seen

unset litlog_src_dir
# location of the lillog .litlog directory
unset litlog_env_path

unset litlog_hist_all
unset litlog_hist_buffer

unset title
unset note
unset private

# remove all adding functions from the shell environment
unset add_top_hist
unset add_bottom_hist
unset add_range_hist
unset add_given_hist
unset add_nodups_hist

# remove other functions
unset add_note

# remove all writing functions from shell environment
unset write_all
unset write_notes
unset write_cmd

# remove all show functions from the shell environment
unset show_cmd
unset show_notes
unset show_location

#
unset litlog_meta_buffer

# remove clear commands from shell's env
unset clear_cmd_buffer
unset clear_notes_buffer
