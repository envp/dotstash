setlocal tabstop=2
setlocal expandtab
setlocal shiftwidth=2
setlocal smarttab

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType haskell nnoremap <buffer> <F3> :!hindent --sort-imports %<CR>

