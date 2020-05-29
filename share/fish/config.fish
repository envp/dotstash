set -g EDITOR nvim

# Git prompt
set __fish_git_prompt_show_informative_status "yes"
set __fish_git_prompt_color_branch brmagenta
set __fish_git_prompt_color_upstream_ahead brgreen
set __fish_git_prompt_color_upstream_behind brred

# Colors in less 
set -gx LESS_TERMCAP_mb (set_color -o brblue)
set -gx LESS_TERMCAP_md (set_color -o bryellow)
set -gx LESS_TERMCAP_me (set_color normal)
set -gx LESS_TERMCAP_so (set_color -o black -b yellow)
set -gx LESS_TERMCAP_se (tput rmso; set_color normal)
set -gx LESS_TERMCAP_us (tput smul; set_color -o white) # white
set -gx LESS_TERMCAP_ue (tput rmul; set_color normal)
set -gx LESS_TERMCAP_mr (set_color --reverse)
set -gx LESS_TERMCAP_mh (set_color --dim)
set -gx LESS_TERMCAP_ZN (tput ssubm)
set -gx LESS_TERMCAP_ZV (tput rsubm)
set -gx LESS_TERMCAP_ZO (tput ssupm)
set -gx LESS_TERMCAP_ZW (tput rsupm)
set -gx GROFF_NO_SGR 1         # For Konsole and Gnome-terminal

# Non standard extensions to $path
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/libiconv/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/coreutils/libexec/gnubin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/findutils/libexec/gnubin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/gawk/libexec/gnubin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/gnu-getopt/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/gnu-indent/libexec/gnubin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/gnu-sed/libexec/gnubin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/gnu-tar/libexec/gnubin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/gnu-which/libexec/gnubin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/llvm/bin" $fish_user_paths
