let g:haskellmode_completion_ghc = 0

setlocal tabstop=2
setlocal softtabstop=0
setlocal expandtab
setlocal shiftwidth=2
setlocal smarttab

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType haskell nnoremap <buffer> <F3> :!brittany --write-mode inplace %

