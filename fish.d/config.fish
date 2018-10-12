function l --description 'Tabular listing of all files and directories with human readable sizes and file type classification'
    ls -halF $argv
end

function g --description 'Alias for git'
    git $argv
end

# Fish git prompt
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_color_branch brmagenta
set __fish_git_prompt_color_upstream_ahead brgreen
set __fish_git_prompt_color_upstream_behind brred

# Status Chars
# set __fish_git_prompt_char_dirtystate '*'
# set __fish_git_prompt_char_stagedstate '+'
# set __fish_git_prompt_char_upstream_ahead '↓'
# set __fish_git_prompt_char_upstream_behind '↑'
# set __fish_git_prompt_char_dirtystate '⚡'
# set __fish_git_prompt_char_stagedstate '→'
# set __fish_git_prompt_char_untrackedfiles '☡'
# set __fish_git_prompt_char_stashstate '↩'
# set __fish_git_prompt_char_upstream_ahead '+'
# set __fish_git_prompt_char_upstream_behind '-'


set -gx EDITOR nvim
set -gx PATH /opt/bb/bin $PATH

set -gx PROXY devproxy.bloomberg.com
set -gx http_proxy $PROXY
set -gx https_proxy $PROXY
