

litlog() {
  litlog_src_dir="$(dirname ${BASH_SOURCE[0]})"
  # number of arguments on cmd
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
        echo "                       N (notes) - show buffering notes so far"
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
        if [[ -n $litlog_env_path ]]
        then
          echo "ERROR: You are already in litlog env -> $litlog_env_path"
          break
        fi

        case "$2" in
          #(--private)
          #  private="PRIVATE_SESSION!"
          #  ;;
          ("")
            litlog_env_path="$PWD"
            ;;
          (*)
            if [[ -d "$2" ]]
            then
              litlog_env_path="$2"
            else
              echo "ERROR: please specify correct path to directory"
            fi
            ;;
        esac
        shift
        source "$litlog_src_dir/activate.bash"
        ;; # past argument
      (deact|deactivate)
        if [[ -z $litlog_env_path ]]
        then
          echo "ERROR: You are not in litlog env -> $litlog_env_path. use litlog activate to start one"
          break
        fi
        source "$litlog_src_dir/deactivate.bash"
        ;;
      (-s|--show)
        case "$2" in
          (N|notes)
            if [[ -n $litlog_notes_buffer ]]
            then
              cat $litlog_notes_buffer
            else
              echo "litlog env hasn't been activated"
            fi
            ;;
          (L|location)
            if [[ -n $litlog_parent_dir ]]
            then
              echo $litlog_parent_dir
            else
              echo "litlog env hasn't been activated"
            fi
            ;;
          (H|help)
            echo ""
            echo "    -s (--show) [OPTIONS]"
            echo "            N (notes) - show buffering notes so far"
            echo "            L (location) - show location of the log file with notes"
            echo ""
            ;;
          (*)
            echo "ERROR: wrong option, use --show help to get all of the options"
        esac
        shift
        ;;
      (-w|--write)
        if [[ -z $litlog_env_path ]]
        then
          echo "ERROR: You are not in litlog env -> $litlog_env_path. use litlog activate to start one"
          break
        fi
        case "$2" in
          (A|all)
            write_all="write_all"
            shift
            ;;
          (C|commands)
            write_history="write_history"
            shift
            ;;
          (N|notes)
            write_notes="write_notes"
            shift
            ;;
          (H|help)
            echo ""
            echo "    -w (--write) [OPTIONS]"
            echo "            A (all) - write notes with history to the log file"
            echo "            C (commands) - write just the history to the log file"
            echo "            N (notes) - write just the notes to the log file"
            echo ""
            shift
            ;;
          (*)
            echo "ERROR: wrong option, use --write help to get all of the options"
            break
            ;;
        esac
        shift
        source "$litlog_src_dir/write.bash"
        ;;
      (-t|--title)
        title="$2"
        # only append title if it was given
        if [[ ! -z $title ]]
        then
          # only append title once to litlog_notes_buffer
          if ! grep -q "$title" "$litlog_notes_buffer"
          then
            echo "%> Title: $title" >> $litlog_notes_buffer
          fi
        fi
        shift # past argument
        ;;
      (-n|--note)
        note="$2"
        if [[ ! -z $note ]]
        then
          echo "%> Note: $note" >> $litlog_notes_buffer
        fi
        shift # past argument
        ;;
      (*)
        echo "ERROR: wrong option, use litlog --help to get all of the options"
        shift
        ;;
    esac
    shift # past argument or value
  done
}
