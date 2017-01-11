
src="${BASH_SOURCE[0]}"
dir=$(dirname $src)

litlog() {
  # unset know variables
  unset title
  unset note
  unset private
  # number of arguments on cmd
  #echo $#
  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      (-h|--help)
        echo ""
        echo "  Version: 0.1.3"
        echo "  Usage: litlog [OPTIONS]"
        echo ""
        echo "  Options: "
        echo ""
        echo "           act (activate) [PATH] - start litlog env, default use PWD variable"
        #echo "           act (activate) [OPTIONS] - to initiate litlog env"
        #echo "                       --private - to initiate private litlog env i.e hidden history"
        echo "           deact (deactivate) - leave litlog env"
        echo ""
        echo "           -t (--title) - add title to buffer"
        echo "           -n (--note) - add notes to buffer"
        echo ""
        echo "           -s (--show) [OPTIONS]"
        echo "                       T (text) - show buffering notes so far"
        echo "                       L (location) - show location of the log file with notes"
        echo ""
        echo "           -w (--write) [OPTIONS]"
        echo "                       A (all) - write notes with history to the log file"
        echo "                       C (commands) - write just the history to the log file"
        echo "                       N (notes) - write just the notes to the log file"
        echo ""
        shift
        ;;
      (act|activate)
        case "$2" in
          (--private)
            private="PRIVATE_SESSION!"
            ;;
          ("")
            env_path="$PWD"
            ;;
          (*)
            if [[ -d "$2" ]]
            then
              env_path="$2"
            else
              echo "ERROR: please specify correct path to directory"
            fi
            ;;
        esac
        shift
        source "$dir/activate.bash"
        ;; # past argument
      (deact|deactivate)
        source "$dir/deactivate.bash"
        ;;
      (-s|--show)
        case "$2" in
          (N|notes)
            if [[ -n $text_file ]]
            then
              cat $text_file
            else
              echo "litlog env hasn't been activated"
            fi
            ;;
          (L|location)
            if [[ -n $parent_dir ]]
            then
              echo $parent_dir
            else
              echo "litlog env hasn't been activated"
            fi
            ;;
          (H|help)
            echo ""
            echo "    -s (--show) [OPTIONS]"
            echo "            T (text) - show buffering notes so far"
            echo "            L (location) - show location of the log file with notes"
            echo ""
            ;;
          (*)
            echo "ERROR: wrong option, use --show help to get all of the options"
        esac
        shift
        ;;
      (-w|--write)
        env_origin=$(dirname $litlog_dir)
        out_file="$env_origin/README.litlog"
        case "$2" in
          (A|all)
            write_all="write_all"
            ;;
          (C|commands)
            write_history="write_history"
            ;;
          (N|notes)
            write_notes="write_notes"
            ;;
          (H|help)
            echo ""
            echo "    -w (--write) [OPTIONS]"
            echo "            A (all) - write notes with history to the log file"
            echo "            C (commands) - write just the history to the log file"
            echo "            N (notes) - write just the notes to the log file"
            echo ""
            ;;
          (*)
            echo "ERROR: wrong option, use --write help to get all of the options"
            #exit 1
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
