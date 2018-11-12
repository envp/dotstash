function lsof --description "List open file descriptors"
    ls -la "/proc/$PID/fd"
end
