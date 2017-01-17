

litlog() {

  if [[ -z "$@" ]]
  then
    litlog -h
  fi

  litlog_src_dir="$(dirname ${BASH_SOURCE[0]})"
  # number of arguments on cmd
  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      (-h|--help)
        echo ""
        echo "  Version: 0.1.4"
        echo "  Usage: litlog [OPTIONS]"
        echo ""
        echo "  Options: "
        echo ""
        echo "           act (activate) [PATH] - start litlog env, default use PWD variable"
        #echo "           act (activate) [OPTIONS] - to initiate litlog env"
        #echo "                       --private - to initiate private litlog env i.e hidden history"
        echo "           deact (deactivate) - leave litlog env"
        echo ""
        echo "           -s (--show) [OPTIONS]"
        echo "                       C (commands) - show buffering commands"
        echo "                       N (notes) - show buffering notes"
        echo "                       L (location) - show location of the log file"
        echo ""
        echo "           -a (--add) [OPTIONS]"
        echo "                       C (commands) [OPTIONS] - add commands to the buffer"
        echo "                               +n - get n numder of lines from the top of the history file"
        echo "                               -n - get n numder of lines from the bottom of the history file"
        echo "                               n - get nth history entry from the history file"
        echo "                               n-m - get n-m range from the history file"
        echo "                               n,m,.. - get these histories from the history file"
        echo ""
        echo "                       N (notes) - add notes to the buffer"
        echo "                       T (title) - add title to the buffer"
        echo ""
        echo "           -w (--write) [OPTIONS]"
        echo "                       C (commands) - write commands to the log file"
        echo "                       N (notes) - write notes to the log file"
        echo ""
        echo "           -c (--clear) [OPTIONS]"
        echo "                       C (commands) - clear commands buffer"
        echo "                       N (notes) - clear notes buffer"
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
        shift
        ;;
      (-s|--show)
        #TODO utilise PAGER variable
        # it is unset for some reason though
        source "$litlog_src_dir/show.bash"
        case "$2" in
          ("")
            show_notes
            show_cmd
            show_metadata
            ;;
          (C|commands) 
            show_cmd
            shift
            ;;
          (N|notes)
            show_notes
            shift
            ;;
          (L|location)
            show_location
            shift
            ;;
          (H|help)
            echo ""
            echo "    -s (--show) [OPTIONS]"
            echo "            C (commands) - show buffering commands so far"
            echo "            N (notes) - show buffering notes so far"
            echo "            L (location) - show location of the log file with notes"
            echo ""
            ;;
          (*)
            echo "ERROR: wrong option, use --show help to get all of the options"
            ;;
        esac
        shift
        ;;
      (-a|--add)
        source "$litlog_src_dir/add.bash"
        case "$2" in
          (C|commands)

            hist_input=$3
            
            if [[ $hist_input =~ ^[0-9]+$ ]]
            then
                add_given_hist "$hist_input"
                echo "Number"
            elif [[ ${hist_input:0:1} == "-" && ${hist_input:1} =~ ^[0-9]+$ ]]
            then
                add_bottom_hist "$hist_input"
                echo "Minus"
            elif [[ ${hist_input:0:1} == "+" && ${hist_input:1} =~ ^[0-9]+$ ]]
            then
                add_top_hist "$hist_input"
                echo "Plus"
            elif [[ $hist_input =~ "-" && ${hist_input%%-*} =~ ^[0-9]+$ && ${hist_input##*-} =~ ^[0-9]+$ ]]
            then
                add_range_hist "$hist_input"
                echo "Rage"
            elif [[ $hist_input =~ "," && ${hist_input%%,*} =~ ^[0-9]+$ && ${hist_input##*,} =~ ^[0-9]+$ ]]
            then
                add_list_hist "$hist_input"
                echo "List"
            elif [[ -z $hist_input ]]
            then
                add_nodups_hist
                echo "Empty"
            else
                echo "ERROR: wrong option, use litlog --add help to get all of the options"
            fi
            shift
            ;;
          (T|title)
            title="$3"
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
          (N|notes)
            add_note "$3"
            shift # past argument
            ;;
          (H|help)
            echo ""
            echo "    -a (--add) [OPTIONS]"
            echo "            C (commands) - add selected commands to buffer"
            echo "                    +n - get n numder of lines from the top of the history file"
            echo "                    -n - get n numder of lines from the bottom of the history file"
            echo "                    n - get nth history entry from the history file"
            echo "                    n-m - get n-m range from the history file"
            echo ""
            echo "            T (title) - add title to buffer"
            echo "            N (notes) - add notes to buffer"
            echo ""
            ;;
          (*)
            echo "ERROR: wrong option, use --add help to get all of the options"
            break
            ;;
        esac
        shift
        ;;
      (-c|--clear)
        source "$litlog_src_dir/litlog_clear.bash"
        case "$2" in
          ("")
            clear_notes_buffer
            clear_cmd_buffer
            shift
            ;;
          (C|commands)
            clear_cmd_buffer
            shift
            ;;
          (N|notes)
            clear_notes_buffer
            shift
            ;;
          (H|help)
            echo ""
            echo "    -c (--clear) [OPTIONS]"
            echo "            C (commands) - clear commands buffer"
            echo "            N (notes) - clear notes buffer"
            echo ""
            shift
            ;;
          (*)
            echo "ERROR: wrong option, use --clear help to get all of the options"
            break
            ;;
        esac
        shift
        ;;
      (-w|--write)
        source "$litlog_src_dir/write.bash"
        if [[ -z $litlog_env_path ]]
        then
          echo "ERROR: You are not in litlog env -> $litlog_env_path. use litlog activate to start one"
          break
        fi
        case "$2" in
          ("")
            write_notes
            write_cmd
            shift
            ;;
          (C|commands)
            write_cmd
            shift
            ;;
          (N|notes)
            write_notes
            shift
            ;;
          (H|help)
            echo ""
            echo "    -w (--write) [OPTIONS]"
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
        ;;
      #(-t|--title)
      #  title="$2"
      #  # only append title if it was given
      #  if [[ ! -z $title ]]
      #  then
      #    # only append title once to litlog_notes_buffer
      #    if ! grep -q "$title" "$litlog_notes_buffer"
      #    then
      #      echo "%> Title: $title" >> $litlog_notes_buffer
      #    fi
      #  fi
      #  shift # past argument
      #  ;;
      #(-n|--note)
      #  note="$2"
      #  if [[ ! -z $note ]]
      #  then
      #    echo "%> Note: $note" >> $litlog_notes_buffer
      #  fi
      #  shift # past argument
      #  ;;
      (*)
        echo "ERROR: wrong option, use litlog --help to get all of the options"
        shift
        ;;
    esac
    shift # past argument or value
  done
}
