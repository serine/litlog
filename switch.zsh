
DATE=`date "+%F"`
TIME=`date "+%T"`

# FILENAME hasn't been writen too therefor it isn't a file yet
# hence -n not -f test
if [[ -n "$FILENAME" && -f "$old_log" ]]
then
  echo "%>Switched logging file from $old_log to  $FILENAME on $DATE at $TIME" >> $old_log
  echo "%>Switched logging file from $old_log to  $FILENAME on $DATE at $TIME" >> $FILENAME
else
  echo "ERROR: This shouldn't have happened "
  echo "ERROR: Please raise an issue here https://github.com/serine/logit/issues"
fi
