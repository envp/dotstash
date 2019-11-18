function fish_greeting
    # Probably find a way to cache this so that we don't query this as
    # frequently
    curl --max-time 0.5 -f "wttr.in/?m" -z /tmp/wttr 2>/dev/null | sed -ne '2,$p;7q'
    gshuf -n 1 ~/.local/share/bofh/excuses
end

function fish_prompt
    # Set up variables that we want to use
    set -l color_cwd brcyan
    set -l color_host bryellow
    set -l color_git magenta
    set -l color_user
    set -l suffix

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

function proxrun --description "Run a command with proxy env vars set"
    begin;
        set -lx ALL_PROXY 'http://proxy.bloomberg.com:77'
        set -lx HTTP_PROXY 'http://proxy.bloomberg.com:77'
        set -lx HTTPS_PROXY 'http://proxy.bloomberg.com:77'
        set -lx http_proxy 'http://proxy.bloomberg.com:77'
        set -lx https_proxy 'http://proxy.bloomberg.com:77'

        eval $argv
    end
end

set -gx EDITOR nvim

##
## Git prompt
##
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_color_branch brmagenta
set __fish_git_prompt_color_upstream_ahead brgreen
set __fish_git_prompt_color_upstream_behind brred

##
## Perl
##
set -x PATH $HOME/Library/Python/3.7/bin /Applications/Postgres.app/Contents/Versions/latest/bin $PATH;
set -q PERL5LIB; and set -x PERL5LIB /home/vyenamandra/perl5/lib/perl5:$PERL5LIB;
set -q PERL5LIB; or set -x PERL5LIB /home/vyenamandra/perl5/lib/perl5;
set -q PERL_LOCAL_LIB_ROOT; and set -x PERL_LOCAL_LIB_ROOT /home/vyenamandra/perl5:$PERL_LOCAL_LIB_ROOT;
set -q PERL_LOCAL_LIB_ROOT; or set -x PERL_LOCAL_LIB_ROOT /home/vyenamandra/perl5;
set -x PERL_MB_OPT --install_base\ \"/home/vyenamandra/perl5\";
set -x PERL_MM_OPT INSTALL_BASE=/home/vyenamandra/perl5;

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

set -gx PIPENV_PYPI_MIRROR 'https://artprod.dev.bloomberg.com/artifactory/api/pypi/bloomberg-pypi/simple'

set -gx no_proxy 'localhost,.dev.bloomberg.com,127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,blp-dpkg.dev.bloomberg.com,.dev.obdc.bcs.bloomberg.com,.bpaas1sn2.dev.bloomberg.com,dob1.bcpc.bloomberg.com'

alias antlr4=antlr
set -gx fish_user_paths ~/.local/bin/ ~/.cargo/bin /usr/local/opt/llvm/bin /usr/local/sbin /usr/local/opt/tcl-tk/bin $fish_user_paths
