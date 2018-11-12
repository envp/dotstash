call plug#begin('~/.local/share/nvim/plugged')
    " Fastswitch (cpp/h toggle)
    Plug 'derekwyatt/vim-fswitch', { 'for': 'cpp' }

    " Fuzzy file search
    Plug 'ctrlpvim/ctrlp.vim'

    " Syntax checking
    Plug 'scrooloose/syntastic'

    " NERDTree file navigation
    Plug 'scrooloose/nerdtree'

    " Matching [({'
    Plug 'spf13/vim-autoclose'

    " Comment/uncomment operator
    Plug 'tpope/vim-commentary'

    " Surrounding stuff with other stuff
    Plug 'tpope/vim-surround'

    " Git features
    Plug 'tpope/vim-fugitive'

    " Git-gutter plugin
    Plug 'airblade/vim-gitgutter'

    " Dot operator for plugins
    Plug 'tpope/vim-repeat'

    " Surrounding text
    Plug 'tpope/vim-surround'

    " Pairs of keyboard mappings for common tasks
    Plug 'tpope/vim-unimpaired'

    " Powerline-like lightweight status bar
    Plug 'vim-airline/vim-airline'

    " Themes for vim-airline status bar
    Plug 'vim-airline/vim-airline-themes'

    " Indentation level guides
    " Plug 'nathanaelkane/vim-indent-guides'
    Plug 'Yggdroot/indentLine'

    " Automagically format code using system formatter
    Plug 'Chiel92/vim-autoformat'

    " Visual studio like appearance
    Plug 'tomasiser/vim-code-dark'

    " Good dark theme
    Plug 'liuchengxu/space-vim-dark'

    " Linting support for various languages
    Plug 'w0rp/ale'

    " Code Completion
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/echodoc.vim'
    Plug 'zchee/deoplete-jedi'

    " Easier to see paratheses matching with this
    Plug 'luochen1990/rainbow'

    " Allow parsing ANSI escape sequences, useful for GTEST/PYTEST
    Plug 'powerman/vim-plugin-AnsiEsc'

    " JEDI autocompletion for python
    Plug 'davidhalter/jedi-vim'

    " CMake Syntax
    Plug 'pboettch/vim-cmake-syntax'

    " Support to edit fish scripts
    Plug 'dag/vim-fish'

    " COLOR SCHEMES~
    Plug 'rakr/vim-one'
    Plug 'ayu-theme/ayu-vim'

    " Deal with csv files
    Plug 'chrisbra/csv.vim'

    " RIP ghc mode
    Plug 'neovimhaskell/haskell-vim'

    " VCS integration across the board
    Plug 'vim-scripts/vcscommand.vim'

    " TagBar
    Plug 'majutsushi/tagbar'
call plug#end()

"" ============================================================================
""                              Plugin Settings
"" ============================================================================
set completeopt=preview,menuone
set completeopt-=preview

let g:vim_markdown_folding_disabled = 1

" Airline
let g:airline_theme = 'one'
let g:airline_extensions = ['branch', 'hunks','tabline', 'ycm', 'ale']
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s: '
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_highlighting_cache = 1
let g:airline#extensions#ale#enabled = 1
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

" GitGutter
let g:gitgutter_max_signs=9999

" NERDTree
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.a$', '\.out$', '\.tsk$', '\.linux$', '^00[[dir]]']

" Syntastic
let g:syntastic_aggregate_errors = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }

" clang_complete
let g:clang_library_path = '/opt/bb/lib/llvm-6.0/lib64/libclang.so'

" Linting with ALE
let g:ale_completion_enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'haskell': ['stack_build', 'hdevtools'],
\   'cpp': ['clang-tidy-6'],
\   'python': ['pylint', 'pycodestyle'],
\   'fish': ['fish -n'],
\   'perl': ['perl']
\}
let g:ale_linters_explicit = 1
let g:ale_cpp_clang_executable = '/usr/bin/clang++-6'
let g:ale_cpp_clang_options = '-std=c++14 -Wall -Werror -pedantic'
let g:ale_cpp_clangcheck_executable = '/opt/bb/lib/llvm-6.0/bin/clang-check'
let g:ale_cpp_cquery_executable = '~/.local/bin/cquery'
let g:ale_cpp_clangtidy_executable = '/opt/bb/bin/clang-tidy-6'

" Completion with LSP
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands.python = ['pyls']
let g:LanguageClient_serverCommands.cpp = ['clangd-7']
let g:LanguageClient_serverCommands.c = ['clangd-7']

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

" Jedi configuration
let g:jedi#usages_command = '<leader>u'
let g:jedi#show_call_signatures = 2

" Deoplete
let g:deoplete#enable_at_startup = 1

" Echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

let ayucolor="dark"

" IndentLine {{
let g:indentLine_char = ''
let g:indentLine_first_char = ''
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}

