" Bold comments and strings
highlight Comment gui=bold guifg=Green

if &background ==# 'dark'
    highlight String gui=bold guifg=#B8CC52
elseif &background ==# 'light'
    highlight String gui=bold
endif
" Eye bleeding red for control chars file
syntax match ControlChar "[\x00-\x1F]"
highlight ControlChar guibg=Red

" Tab Chars showng with eye-piercing red
highlight TrailingSpaceChar ctermbg=Red guibg=Red
syntax match TrailingSpaceChar " *$"
