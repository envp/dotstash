" Load functions
source ~/.config/nvim/startup/functions/vimscript-helpers.vim
source ~/.config/nvim/startup/functions/environment.vim
source ~/.config/nvim/startup/functions/directories.vim
source ~/.config/nvim/startup/functions/formatting.vim

" Load each specialized settings file
source ~/.config/nvim/startup/plugins.vim
source ~/.config/nvim/startup/settings.vim
source ~/.config/nvim/startup/mappings.vim

set background=dark
colorscheme ayu

" ColorScheme overrides
highlight ColorColumn guifg=Black guibg=White
highlight VertSplit guifg=Black guibg=Gray
highlight Normal guibg=Black
highlight Error guifg=#FF3333 guibg=None

" Kind of needed for alacritty to work
" Plus its nice to know exactly which line I'm at
" Feeling smart, might delete this later
highlight CursorLine guifg=Black guibg=Gray
highlight CursorColumn guifg=Black guibg=Gray
highlight VertSplit guifg=White guibg=Gray
highlight StatusLineNC gui=bold guifg=White guibg=Black

" Override nerdtree colors
highlight NERDTreeOpenable guifg=#30E040
highlight NERDTreeClosable guifg=Red
highlight NERDTreeBookmarksHeader guifg=Cyan
highlight NERDTreeBookmarksLeader guifg=#30E040
highlight NERDTreeBookmarkName guifg=Yellow
highlight NERDTreeCWD guifg=Orange
highlight NERDTreeUp guifg=White
highlight NERDTreeDir guifg=#30A040
highlight NERDTreeFile guifg=White
highlight NERDTreeDirSlash guifg=Yellow

" Bright White for line numbers
highlight LineNr ctermfg=Gray guifg=Gray

" Bold comments and strings
highlight Comment gui=bold guifg=Green
highlight String gui=bold guifg=#B8CC52

" Eye bleeding red for control chars in file
syntax match ControlChar "[\x00-\x1F]"
highlight ControlChar guibg=Red

" Tab Chars showng with gray
highlight TrailingSpaceChar ctermbg=Red guibg=Red
syntax match TrailingSpaceChar " *$"
