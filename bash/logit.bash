
src="${BASH_SOURCE[0]}"
dir=$(dirname $src)

logit() {
  # unset know variables
  unset title
  unset note
  unset old_log
  # number of arguments on cmd
  #echo $#
  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      (-h|--help)
        echo ""
        echo "  Usage: logit [OPTION]"
        echo ""
        echo "  Options: "
        echo ""
        echo "           act (activate) - to initiate logit env"
        echo "           deact (deactivate) - to leave logit env"
        echo "           -t (--title) - to add a title to your log"
        echo "           -n (--note) - to add a note to your log"
        echo "           -s (--show) - to show logging notes thus far"
        echo "           -w (--write) [FILENAME] - to write logging notes to a file"
        echo ""
        shift
        ;;
      (act|activate)
        source "$dir/activate.bash"
        ;; # past argument
      (deact|deactivate)
        source "$dir/deactivate.bash"
        ;;
      (-s|--show)
        case "$2" in
          (t|text)
            if [[ -n $text_file ]]
            then
              cat $text_file
            else
              echo "logit env hasn't been activated"
            fi
            ;;
          (l|location)
            if [[ -n $parent_dir ]]
            then
              echo $parent_dir
            else
              echo "logit env hasn't been activated"
            fi
            ;;
        esac
        shift
        ;;
      (-w|--write)
        env_origin=$(basename $logit_dir)
        case "$2" in
          ("")
            out_file="$env_origin/../LOG.txt"
            ;;
          (*)
            out_file="$env_origin/../$2"
            ;;
        esac
        source "$dir/write.bash"
        ;;
      (-t|--title)
        title="$2"
        # only append title if it was given
        if [[ ! -z $title ]]
        then
          # only append title once to text_file
          if ! grep -q "$title" "$text_file"
          then
            echo "%> Title: $title" >> $text_file
          fi
        fi
        shift # past argument
        ;;
      (-n|--note)
        note="$2"
        if [[ ! -z $note ]]
        then
          echo "%> Note: $note" >> $text_file
        fi
        shift # past argument
        ;;
    esac
    shift # past argument or value
  done
}
