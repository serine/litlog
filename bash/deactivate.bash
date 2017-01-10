

echo "%> Deactivated on $DATE at $TIME" >> $text_file

#cat $HISTFILE | grep -v "^%>" >> $sys_hist_file
PS1=$user_prompt

#PROMOT_COMMAND=$user_prompt_cmd
HISTFILE=$sys_histfile

HISTIGNORE=$user_histignore
HISTTIMEFORMAT=$user_histtimeformat
HISTCONTROL=$user_histcontrol

shopt -u histappend ## append, no clearouts
shopt -u histverify ## edit a recalled history line before executing
shopt -u histreedit ## reedit a history substitution line if it failed 
