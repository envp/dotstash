"" ============================================================================
""                                 Settings
"" ============================================================================
set nocompatible
if ! has('nvim')
    set clipboard=exclude:.*
endif
"" ============================================================================
""                                  Globals
"" ============================================================================
" Python env
if executable('python') > 0
    let g:python2_host_prog = 'python'
endif

if executable('python3.7') > 0
    let g:python3_host_prog = 'python3.7'
elseif executable('python3') > 0
    let g:python3_host_prog = 'python3'
endif

" Determine Environment
let g:platform = GetPlatform()

" Leader key is <comma>
let mapleader = ','


" To enable the saving and restoring of screen positions.
let g:screen_size_restore_pos = 1

"" ============================================================================
""                            Editing and Moving
"" ============================================================================
if !exists("g:syntax_on")
    syntax enable
endif

" Turns on autodetection, plugins and indentation for files
" See `:help :filetype-overview`
filetype plugin indent on
set autoindent
set cindent
set hidden
set noshowmode
set nospell
set backspace=indent,eol,start

" Get rid of terminal bell sound
set visualbell t_vb=

" Backup directory for swp files
set noswapfile
set directory=""

" runtime path search for Ex
set ru
set path+=**

" Fixing tabs
set tabstop=4
set expandtab
set shiftwidth=4

" 79 char maximum column width
set colorcolumn=79

" Disable autowrapping by default
set textwidth=0 wrapmargin=0

" Always draw this
set signcolumn=yes

" Underline the line at which cursor is present because I can't see a tiny green rectangle
" set cursorline
" set cursorcolumn

" Highlight trailing whitespaces in eye-piercing red
highlight ExtraWhitespace ctermbg=red guibg=red

" Autosave before :make and other commands; autoreload when file mod
set autowrite
set autoread

" Ignore whitespace on diffs
set diffopt+=iwhite

" Smart case sensitivity
set ignorecase
set smartcase

" Fix background color
set t_ut=
set t_Co=256
"set background=dark

" Speed up ViM
set lazyredraw

" When multiple completions are possible, show all
set wildmenu

" Complete only up to point of ambiguity, like the shell does
set wildmode=list:longest

" Ignoring files (see :help wildignore)
set wildignore+=*/.git/*,*/tmp/*,*/build/*,*.o,nohup.out,*.pyc

" Number of lines to scroll past when the cursor scrolls off the screen
set scrolloff=8

"" ============================================================================
""                                Appearances
"" ============================================================================\

" set t_Co=256
set termguicolors
set t_ti = t_te =

" Show line numbers
set number

" Status bar
set laststatus=2
set statusline =
" Buffer number
set statusline +=[%n]
" File description
set statusline +=%f\ %h%m%r%w
" Filetype
set statusline +=%y
" Date of the last time the file was saved
set statusline +=\ %{strftime(\"[%d/%m/%y\ %T]\",getftime(expand(\"%:p\")))}
" Total number of lines in the file
set statusline +=%=%-10L
" Line, column and percentage
set statusline +=%=%-14.(%l,%c%V%)\ %Pset statusline +=[%n]

" Enable mouse pointer, if available
set mouse=a

" Show tab and trailing whitespace characters
set listchars=tab:>-,trail:-
set list!

" Incremental Search and Highlighting Results
set inccommand=nosplit
set incsearch
set hlsearch
set showmatch

" Set the folding method
set foldenable
set foldmethod=manual

"" ============================================================================
""                               Auto Commands
"" ============================================================================
" Automatically open the QuickFix Window after a make
autocmd QuickFixCmdPost *make* cwindow

" Make
autocmd FileType make setlocal noexpandtab shiftwidth=8

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" TypeScript
autocmd BufNewFile,BufReadPost *.ts set filetype=typescript

" AutoSave/AutoLoad views and folds etc
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" Highlight extra white spaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter *.* match ExtraWhitespace /\s\+$/
autocmd InsertEnter *.* match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave *.* match ExtraWhitespace /\s\+$/
autocmd BufWinLeave *.* call clearmatches()

" Haskell file configurations
autocmd! FileType haskell setlocal tabstop=2
autocmd! FileType haskell setlocal shiftwidth=2

" Rainbow parens mess with CMake syntax highlighting :(
autocmd FileType cmake call rainbow_main#clear()

autocmd! FileType haskell map <buffer> <F3> :!hindent %<CR>
