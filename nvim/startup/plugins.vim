call plug#begin('~/.local/share/nvim/plugged')
    " Fuzzy file search
    Plug 'ctrlpvim/ctrlp.vim'

    " NERDTree file navigation
    Plug 'scrooloose/nerdtree'

    " Matching [({'
    Plug 'spf13/vim-autoclose'

    " Comment/uncomment operator
    Plug 'tpope/vim-commentary'

    " Git features
    Plug 'tpope/vim-fugitive'

    " Git-gutter plugin
    Plug 'airblade/vim-gitgutter'

    " Powerline-like lightweight status bar
    Plug 'vim-airline/vim-airline'

    " Themes for vim-airline status bar
    Plug 'vim-airline/vim-airline-themes'

    " Code Completion
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2'
    " Plug 'ncm2/ncm2-pyclang'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'

    " Easier to see paratheses matching with this
    Plug 'luochen1990/rainbow'

    " Allow parsing ANSI escape sequences, useful for GTEST/PYTEST
    Plug 'powerman/vim-plugin-AnsiEsc'

    " CMake Syntax
    Plug 'pboettch/vim-cmake-syntax'

    " Support to edit fish scripts
    Plug 'dag/vim-fish'

    " COLOR SCHEMES~
    Plug 'ayu-theme/ayu-vim'

    " Deal with csv files
    Plug 'chrisbra/csv.vim'
    Plug 'chrisbra/Colorizer'

    Plug 'jceb/vim-orgmode'
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

    Plug 'NLKNguyen/papercolor-theme'

    Plug 'leafgarland/typescript-vim'
call plug#end()
"" ============================================================================
""                              Plugin Settings
"" ============================================================================
let g:vim_markdown_folding_disabled = 1

" Airline
let g:airline_theme = 'papercolor'
let g:airline_extensions = ['branch', 'hunks','tabline', 'coc']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s: '
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_highlighting_cache = 1
" let g:airline#extensions#ale#enabled = 0
let g:airline_mode_map = {
\ '__' : '-',
\ 'n'  : 'N',
\ 'i'  : 'I',
\ 'R'  : 'R',
\ 'c'  : 'C',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '' : 'V',
\ 's'  : 'S',
\ }
let g:airline_section_z = '%3p%% %l/%L:%3v'

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.git']
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
elseif executable('ag')
    let g:ctrlp_user_command = 'ag --hidden -U --ignore .git -g %s'
    let g:ctrlp_use_caching = 0
else
    let g:ctrlp_user_command = 'find %s -type f'
    let g:ctrlp_use_caching = 1
endif


" GitGutter
let g:gitgutter_max_signs=9999

" NERDTree
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.a$', '\.tsk$', '\.linux$']

" Completion with LSP
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands.python = ['pyls']
let g:LanguageClient_serverCommands.cpp = ['clangd']
let g:LanguageClient_serverCommands.c = ['clangd']
let g:LanguageClient_serverCommands.rust = ['~/.cargo/bin/rustup', 'run', 'stable', 'rls']
let g:LanguageClient_serverCommands.javascript = ['typescript-language-server', '--stdio']
let g:LanguageClient_serverCommands.typescript = ['typescript-language-server', '--stdio']

" NCM2 thingies
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" let g:ncm2_pyclang#library_path = '/usr/local/opt/llvm/lib/libclang.dylib'
" let g:ncm2_pyclang#database_path = [
"             \ 'compile_commands.json',
"             \ 'build/compile_commands.json'
"             \ ]

" Rainbow parens
let g:rainbow_active = 1
let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'lisp': {
            \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
            \       },
            \       'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}

" Echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

let ayucolor="dark"
