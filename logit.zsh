
#[ ${ZSH_VERSION} ] && precmd() { chk; }
# Use -gt 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use -gt 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
# note: if this is set to -gt 0 the /etc/hosts part is not recognized ( may be a bug )

autoload colors
colors

#SOURCE=${(%):-%N)}
src=$(readlink -f "$0")
dir=$(dirname $src)

logit() {
  # unset know variables
  unset TITLE
  unset MESSAGE
  # number of arguments on cmd
  #echo $#
  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      act|activate)
        case "$2" in
          "")
            FILENAME="LOG.txt"
            ;;
          *)
            FILENAME="$2"
            shift
            ;;
        esac
        source "$dir/activate.zsh"
        ;; # past argument
      deact|deactivate)
        source "$dir/deactivate.zsh"
        ;;
      -t|--title)
      TITLE="$2"
      # only append title if it was given
      if [[ ! -z $TITLE ]]
      then
        # and if it isn't a duplicate for the cases
        # when the same logit -t command reused with now
        # new -m MESSAGE option
        if ! grep -q "# $TITLE" "$FILENAME"
        then
          echo "# $TITLE" >> $FILENAME
          echo "" >> $FILENAME
        fi
      fi
      shift # past argument
      ;;
      -m|--message)
      MESSAGE="$2"
      if [[ ! -z $MESSAGE ]]
      then
        echo $MESSAGE >> $FILENAME
        echo "" >> $FILENAME
      fi
      shift # past argument
      ;;
    esac
    shift # past argument or value
  done
}
