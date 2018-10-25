setlocal nofoldenable
setlocal foldmethod=syntax
setlocal foldnestmax=10
setlocal foldlevel=2

setlocal textwidth=79

setlocal omnifunc=omni#cpp#complete#Main

nnoremap <buffer> <F3> :Autoformat<CR>
inoremap <buffer> <F3> :Autoformat<CR>
