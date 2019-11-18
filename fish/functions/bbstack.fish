# Defined in /var/folders/h9/kx3mx8md29n5qg1fxb6kfk480000gp/T//fish.KuQSR0/bbstack.fish @ line 2
function bbstack
	begin;
        set -lx STACK_CONFIG ~/.config/stack/bbhackage.yaml;
        stack $argv;
    end;
end
