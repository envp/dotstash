" Load functions
source ~/.config/nvim/startup/functions/vimscript-helpers.vim
source ~/.config/nvim/startup/functions/environment.vim
source ~/.config/nvim/startup/functions/directories.vim
source ~/.config/nvim/startup/functions/formatting.vim

" Load each specialized settings file
source ~/.config/nvim/startup/plugins.vim
source ~/.config/nvim/startup/settings.vim
source ~/.config/nvim/startup/mappings.vim

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'override' : {
  \         'color00' : ['#DADADA', ''],
  \         'vertsplit_bg' : ['#DADADA', ''],
  \         'linenumber_bg' : ['#DADADA', ''],
  \         'cursorcolumn' : ['#FF005F', ''],
  \       }
  \     }
  \   }
  \ }
set background=light
colorscheme PaperColor

" Common colorscheme overrides
source ~/.config/nvim/startup/overrides/common.vim

" Overrides for specific schemes
if get(g:, 'colors_name', 'default') == 'ayu' && get(g:, 'ayucolor', 'none') == 'dark'
    source ~/.config/nvim/startup/overrides/ayu.vim
endif
