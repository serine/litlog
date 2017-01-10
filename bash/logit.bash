
src="${BASH_SOURCE[0]}"
dir=$(dirname $src)

logit() {
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
        echo "  Version: 0.1.1"
        echo "  Usage: logit [OPTIONS]"
        echo ""
        echo "  Options: "
        echo ""
        echo "           act (activate) [PATH] - start logit env, default use PWD variable"
        #echo "           act (activate) [OPTIONS] - to initiate logit env"
        #echo "                       --private - to initiate private logit env i.e hidden history"
        echo "           deact (deactivate) - leave logit env"
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
        echo "                       H (history) - write just the history to the log file"
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
              exit 1
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
              echo "logit env hasn't been activated"
            fi
            ;;
          (L|location)
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
        env_origin=$(dirname $logit_dir)
        out_file="$env_origin/README.logit"
        case "$2" in
          (A|all)
            write_all="write_all"
            ;;
          (H|history)
            write_history="write_history"
            ;;
          (N|notes)
            write_notes="write_notes"
            ;;
          #("")
          #  out_file="$env_origin/../LOG.txt"
          #  ;;
          #(*)
          #  out_file="$env_origin/../$2"
          #  ;;
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
