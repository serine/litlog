
#[ ${ZSH_VERSION} ] && precmd() { chk; }
# Use -gt 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use -gt 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
# note: if this is set to -gt 0 the /etc/hosts part is not recognized ( may be a bug )

logit() {
  # unset know variables
  unset TITLE
  unset MESSAGE
  # set the default value
  DATE=`date "+%F"`
  FILENAME="LOGIT.md"
  # number of arguments on cmd
  #echo $#
  while [[ $# -gt 1 ]]
  do
    key="$1"

    case $key in
      -t|--title)
        TITLE="$2"
        shift
        ;; # past argument
      -m|--message)
      MESSAGE="$2"
      shift # past argument
      ;;
      -f|--file)
      FILENAME="$2"
      shift # past argument
      ;;
      --default)
      DEFAULT=YES
      ;;
    esac
    shift # past argument or value
  done
  # check that file exists and is a regular file
  if [[ ! -f $FILENAME ]]
  then
    touch $FILENAME
  fi
  # only append date string once a day
  if ! grep -q $DATE "$FILENAME"
  then
    echo "%>$DATE" >> $FILENAME
  fi
  # only append title if it was given
  if [[ ! -z $TITLE ]]
  then
    echo "# $TITLE" >> $FILENAME
  fi
  if [[ ! -z $MESSAGE ]]
  then
    echo >> $FILENAME
    echo $MESSAGE >> $FILENAME
    echo >> $FILENAME
  fi
}

_per-directory-history-addhistory() {
  print -Sr -- "${1%%$'\n'}"
  fc -p $FILENAME
}
# load hooks function
# for builtin functions -U flag is recomeneded
autoload -U add-zsh-hook
add-zsh-hook zshaddhistory _per-directory-history-addhistory

