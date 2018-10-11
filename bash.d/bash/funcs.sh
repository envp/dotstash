# shellcheck disable=SC2086,SC2046

function lcr {
    llcalc --create $1 && llcalc --run --unbounded $1
}

function clang-ast {
    clang -fcolor-diagnostics -Xclang -ast-dump $@
}

function autobuild {
    while inotifywait -e create,close_write,delete, -r $1; do
        (exec $2;)
    done;
}

function cs {
    cd "$@" && ls -latrh
}

# Pretty print a basclient response
function basclient-pretty {
    # Usage:
    # basclient-pretty <XSD file> <Request XML>
    #
    # -OR-
    #
    # basclient-pretty <XSD-FILE> <SERVICE-INFO> <REQUEST-XML>

    if [ "$#" -eq 2 ]; then
        basclient -x $1 $2 | \grep -oe "{.*}" | python -c "exec(\"import json\nprint(json.dumps(json.loads(raw_input()), indent=2))\")"
    elif [ "$#" -eq 3 ]; then
        basclient -x $1 $2 $3 | \grep -oe "{.*}" | python -c "exec(\"import json\nprint(json.dumps(json.loads(raw_input()), indent=2))\")"
    else
        set -e 1
        return;
    fi
}

# File only files
function ff {
    if [ $# -ne 2 ]; then
        echo "Usage: ff <path> <pattern>"
        set -e 1;
        return;
    fi
    find $1 -type f -name $2
}

# Compress a folder to *.tar.gz with progress
function archive {
    tar cf - $1/ -P --exclude .git --exclude "*.log" | pv -s $(du -sb $1/ | awk '{print $1}') | gzip > $1.tgz
}

# Extract any compressed file format
function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "         extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        return 1
     else
        for n in "$@"
        do
          if [ -f "$n" ] ; then
              case "${n%,}" in
                *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                    tar xvf "$n"
                    ;;
                *.lzma)
                    unlzma ./"$n"
                    ;;
                *.bz2)
                    bunzip2 ./"$n"
                    ;;
                *.rar)
                    unrar x -ad ./"$n"
                    ;;
                *.gz)
                    gunzip ./"$n"
                    ;;
                *.zip)
                    unzip ./"$n"
                    ;;
                *.z)
                    uncompress ./"$n"
                    ;;
                *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                    7z x ./"$n"
                    ;;
                *.xz)
                    unxz ./"$n"
                    ;;
                *.exe)
                    cabextract ./"$n"
                    ;;
                *)
                    echo "extract: '$n' - unknown archive method"
                    return 1
                    ;;
              esac
          else
              echo "'$n' - file does not exist"
              return 1
          fi
        done
    fi
}

# Create a directory and move into it
function mkd {
    mkdir -p "$@" && cd "$_"
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function colftree {
    tree -aC -I '.git|node_modules|bower_components|__pycache__' --dirsfirst "$@" | less -FRNX;
}

# Pick the right tool based on where this commmand is run
# -d Always use mv
function smart-mv {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo 'Using git mv for moving files...'
        git mv "$@"
    else
        mv "$@"
    fi
}
