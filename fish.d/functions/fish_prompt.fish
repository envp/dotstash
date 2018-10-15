function fish_prompt
    # Set up variables that we want to use
    set -l color_cwd brcyan
    set -l color_host bryellow
    set -l color_git magenta
    set -l color_user
    set -l suffix
    set -l prefix

    # Set up the prompt to show the if the last exit status was a success
    if test $status -eq 0
        set suffix (set_color green) 'λ' (set_color normal)
    else
        set suffix (set_color red) 'λ' (set_color normal)
    end

    # Do this only once (borrowed from original fish_prompt code)
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    # BRIGHT MAGENTA for root becuase we it is important to know when you're
    # root
    switch $USER
        case root toor
            set color_user brmagenta
        case '*'
            set color_user brgreen
    end

    # The actual prompt
    echo -n -s (set_color $color_user) "$USER" (set_color normal)             \
        @                                                                     \
        (set_color $color_host) "$__fish_prompt_hostname" (set_color normal)  \
        ':'                                                                   \
        (set_color $color_cwd) (prompt_pwd) (set_color normal)                \
        (__fish_git_prompt)                                                   \
        "$suffix"
end

