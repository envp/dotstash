"" ============================================================================
""                             All Mode Mappings
"" ============================================================================
map <C-l> :nohlsearch<CR>
map <silent <S-Insert> "+p
nmap <F8> :TagbarToggle<CR>
nmap <F12> :FSHere<CR>
noremap <F5> :RainbowToggle<CR>

if has("gui_running")
    map  <silent>  <S-Insert>  "+p
    imap <silent>  <S-Insert>  <Esc>"+p
endif

map <C-]> :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>

"" ============================================================================
""                           Insert Mode Mappings
"" ============================================================================
" Leaving insert mode with jj or jk
inoremap jj <Esc><Right>
inoremap jk <Esc><Right>
inoremap ww <Esc><Right><CR>:w<CR>i
imap <silent <S-Insert> <Esc>"+p
"" ============================================================================
""                        Normal/Visual Mode Mappings
"" ============================================================================
" If hl search is off, starting a new search or moving enables it
nnoremap * :set hlsearch<CR>*
nnoremap # :set hlsearch<CR>#
nnoremap n :set hlsearch<CR>n
nnoremap N :set hlsearch<CR>N
nnoremap / :set hlsearch<CR>/
nnoremap ? :set hlsearch<CR>?

" Space toggles folds
nnoremap <space> za<CR>
" <C-l> rids of the highlights
nnoremap <silent> <C-l> :nohl<CR><C-l>
nnoremap <F4> :setlocal spell!<CR>
nnoremap <F6> :set rnu!<CR>

"" ============================================================================
""                         Leader Mappings (Sorted)
"" ============================================================================

" Open a new empty buffer
nmap <leader>bb :enew<CR>

" Move to the next buffer (right)
nmap <leader>bn :bnext<CR>

" Move to the previous buffer (left)
nmap <leader>bv :bprevious<CR>

" Delete the current buffer and move to the previous one
nmap <leader>bq :bdelete<BAR>:bp<CR>

" List all open buffers with status info
nmap <leader>bl :ls<CR>

" Clear line and change mode to INSERT
nnoremap <leader>c dd0<CR>

nnoremap <leader>cdr :call Cdroot()<CR>
" Delete current line
nnoremap <leader>d dd<CR>

nnoremap <leader>df :Gdiff<CR>
nnoremap <leader>dom :Gdiff origin/master<CR>
nnoremap <leader>ff :FSHere<CR>
nnoremap <leader>fh :FSSplitLeft<CR>
nnoremap <leader>fj :FSSplitBelow<CR>
nnoremap <leader>fk :FSSplitAbove<CR>
nnoremap <leader>fl :FSSplitRight<CR>
nnoremap <leader>h :set hlsearch! hlsearch?<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>ss :call SortSection()<CR>
nnoremap <leader>w :call StripTabsAndTrailingWhitespaces()<CR>:w<CR>

" Quickfix and loclist toggle
nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>

" ALE mapping
map <leader>an :ALENext<CR>
map <leader>ap :ALEPrevious<CR>
map <leader>at :ALEToggle<CR>
map <leader>atb :ALEToggleBuffer<CR>
