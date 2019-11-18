function l -d 'Tabular listing of all files and directories with human readable sizes and file type classification'
    ls -halF $argv
end

function nv --wraps nvim -d 'Alias for neovim'
    nvim $argv
end

function g --wraps git -d 'Alias for git'
    git $argv
end

