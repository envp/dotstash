#!/bin/bash

# Git prompt
prompt_git() {
  local s='';
  local branchName='';

  # Check if the current directory is in a Git repository.
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

      # Ensure the index is up to date.
      git update-index --really-refresh -q &>/dev/null;

      # Check for uncommitted changes in the index.
      if ! $(git diff --quiet --ignore-submodules --cached); then
        s+='+';
      fi;

      # Check for unstaged changes.
      if ! $(git diff-files --quiet --ignore-submodules --); then
        s+='!';
      fi;

      # Check for untracked files.
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        s+='?';
      fi;

      # Check for stashed files.
      if $(git rev-parse --verify refs/stash &>/dev/null); then
        s+='$';
      fi;

    fi;

    # Get the short symbolic ref.
    # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
    # Otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
      git rev-parse --short HEAD 2> /dev/null || \
      echo '(unknown)')";

    [ -n "${s}" ] && s=" [${s}]";

    echo -e "${1}${branchName}${2}${s}";
  else
    return;
  fi;
}

function __long_prompt_command() {
    local lastExitStatus=$1;
    # Fix colors to be used here
    local reset="\\e[0m";
    local black="\\e[1;30m";
    local blue="\\e[1;34m";
    local cyan="\\e[1;36m";
    local green="\\e[1;32m";
    local orange="\\e[1;33m";
    local purple="\\e[1;35m";
    local red="\\e[1;31m";
    local violet="\\e[1;35m";
    local white="\\e[1;37m";
    local yellow="\\e[1;33m";

    # Highlight the user name when logged in as root.
    if [[ "${USER}" == "root" ]]; then
      userStyle="${red}";
    else
      userStyle="${green}";
    fi;

    PS1=""
    # Set the terminal title and prompt.
    if [[ $lastExitStatus != 0 ]]; then
      PS1="\[${red}✕\] ";
    else
      PS1="\[${green}✔\] ";
    fi;

    if [ -n "$VIRTUAL_ENV" ]; then  # virtualenv name
        PS1+="(${purple}`basename ${VIRTUAL_ENV}`${reset}) "
    fi;
    # Show only the last 3 dirnames
    PROMPT_DIRTRIM=3
    PS1+="\[${userStyle}\]\u";      # username
    PS1+="\[${white}\]@";           # @
    PS1+="\[${yellow}\]\h";         # host
    PS1+="\[${white}\]:";           # :
    PS1+="\[${cyan}\]\w";           # working directory full path
    PS1+="\$(prompt_git \"\[${white}\] (\[${violet}\]\" \"\[${white}\])\")"; # Git repository details
    PS1+="\[${orange}\]"
    # PS1+="\n";
    PS1+="\[${white}\] λ \[${reset}\]"; # `λ` (and reset color)
    export PS1;

    PS2="\[${yellow}\]> \[${reset}\]";
    export PS2;
}

function __short_prompt_command {
    local lastExitStatus=$1;
    # Fix colors to be used here
    local reset="\\e[0m";
    local black="\\e[1;30m";
    local blue="\\e[1;34m";
    local cyan="\\e[1;36m";
    local green="\\e[1;32m";
    local orange="\\e[1;33m";
    local purple="\\e[1;35m";
    local red="\\e[1;31m";
    local violet="\\e[1;35m";
    local white="\\e[1;37m";
    local yellow="\\e[1;33m";

    PS1=""
    # Set the terminal title and prompt.
    if [[ $lastExitStatus != 0 ]]; then
      PS1="\[${red}✕\] ";
    else
      PS1="\[${green}✔\] ";
    fi;

    if [ -n "$VIRTUAL_ENV" ]; then  # virtualenv name
        PS1+="(${purple}`basename ${VIRTUAL_ENV}`${reset}) "
    fi;
    PS1+="\$(prompt_git \"\[${white}\] (\[${violet}\]\" \"\[${white}\])\")"; # Git repository details
    PS1+="\[${yellow}\] λ \[${reset}\]"; # `λ` (and reset color)
    export PS1;

    PS2="\[${yellow}\]> \[${reset}\]";
    export PS2;

}

function __prompt_command {
    local lastStatus=$?
    if [[ $SHORTEN_PS1 == 1 ]]; then
        __short_prompt_command $lastStatus
    else
        __long_prompt_command $lastStatus
    fi
}

function toggle-prompt {
    if [[ $SHORTEN_PS1 == 0 ]]; then
        export SHORTEN_PS1=1;
        return 0;
    else
        export SHORTEN_PS1=0;
        return 0;
    fi
}

export SHORTEN_PS1=0;
export PROMPT_COMMAND=__prompt_command;
