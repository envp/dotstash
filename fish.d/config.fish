source ~/.config/fish/functions/nav.fish
source ~/.config/fish/functions/aliases.fish

##
## Fish git prompt
##
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_color_branch brmagenta
set __fish_git_prompt_color_upstream_ahead brgreen
set __fish_git_prompt_color_upstream_behind brred

set -gx EDITOR nvim
set -gx LANG 'en_US.UTF-8'


##
## Proxy config
##
set -gx PROXY devproxy.bloomberg.com:82
set -gx http_proxy 'http://'$PROXY
set -gx https_proxy 'https://'$PROXY
set -gx no_proxy 'localhost,.dev.bloomberg.com,127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,blp-dpkg.dev.bloomberg.com'
##
## Perl
##
set -x PATH /home/vyenamandra/perl5/bin $PATH ^/dev/null;
set -q PERL5LIB; and set -x PERL5LIB /home/vyenamandra/perl5/lib/perl5:$PERL5LIB;
set -q PERL5LIB; or set -x PERL5LIB /home/vyenamandra/perl5/lib/perl5;
set -q PERL_LOCAL_LIB_ROOT; and set -x PERL_LOCAL_LIB_ROOT /home/vyenamandra/perl5:$PERL_LOCAL_LIB_ROOT;
set -q PERL_LOCAL_LIB_ROOT; or set -x PERL_LOCAL_LIB_ROOT /home/vyenamandra/perl5;
set -x PERL_MB_OPT --install_base\ \"/home/vyenamandra/perl5\";
set -x PERL_MM_OPT INSTALL_BASE=/home/vyenamandra/perl5;

set -gx PATH /opt/bb/bin $HOME/.local/bin $PATH
