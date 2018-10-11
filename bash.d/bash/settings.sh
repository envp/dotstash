# Append it's arglist to $PATH iff the arguments are new to the $PATH variable
function path-prepend {
    for arg in $@; do
        if ! [[ $PATH =~ "$arg" ]]; then
            PATH="$arg:$PATH"
        fi
    done
}

## ============================================================================
##                           Environment Variables
## ============================================================================

export GTEST_COLOR=yes
export EDITOR=nvim

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Have less display colours
# from: https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
export MANPAGER='less -s -M +Gg';

# Reduce delay to 0.1 seconds for switching to normal mode with ESC
export KEYTIMEOUT=1

path-prepend "/usr/local/sbin"
path-prepend "/usr/local/bin"
path-prepend "/usr/sbin"
path-prepend "/usr/bin"
path-prepend "$HOME/.local/bin"
path-prepend "/bb/shared/bin"
path-prepend "/opt/bb/bin"

export HTTP{,S}_PROXY="devproxy.bloomberg.com:82"
export http{,s}_proxy="devproxy.bloomberg.com:82"
export no_proxy="localhost,.dev.bloomberg.com,127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"

## ============================================================================
##                                 Settings
## ============================================================================
# Unmap ctrl-s as "stop flow"
stty stop undef

# Fix vim backspace issue
stty erase '^?'

# set -o vi
set bell-style none

# Avoid overlay files
set -o noclobber

# Unveils hidden failures
set -o pipefail

# Update winsize after each command for better line-wrapping
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
