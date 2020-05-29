" Language providers
let g:python2_host_program = '/usr/bin/python'
let g:python3_host_program = '/usr/bin/python3'

syntax enable
set number
set hidden
set noswapfile
set signcolumn=yes
set noshowmode

" Automatically save, reload files
set autoread
set autowrite

" Smartcase
set ignorecase
set smartcase

" Allow using a mouse
set mouse=a

" Fixing tabs
set tabstop=4
set expandtab
set shiftwidth=4

" Show tab and trailing whitespace characters, but not by default
" reduce visual clutter
set listchars=tab:\|•,trail:-,eol:¬,extends:>,precedes:\<
set nolist

" Search options
set inccommand=nosplit
set incsearch
set hlsearch
set showmatch

if has("termguicolors")
    set termguicolors
endif

set rtp+=/usr/local/opt/fzf
set completeopt-=preview
set completeopt+=noinsert,menuone

call plug#begin('~/.local/share/nvim/plugged')
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'ncm2/float-preview.nvim'
    Plug 'Shougo/echodoc.vim'
call plug#end()

" Colors & look
set background=light
set colorcolumn=80
colorscheme morning

" Airline
let g:airline_theme = 'atomic'
let g:airline_extensions = ['branch', 'hunks', 'tabline', 'coc']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s: '
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_highlighting_cache = 1

" Deoplete
let g:deoplete#enable_at_startup = 1

" LanguageClient-neovim settings
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands.python = ['/Users/dimsum/Library/Python/3.7/bin/pyls']

" echodoc.vim
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'

" float-preview
let g:float_preview#docked = 0
let g:float_preview#max_width = 100

" Keybindings
let mapleader=','
nnoremap <C-p> :FZF<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
map <C-]> :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
