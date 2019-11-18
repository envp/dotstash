" Vimscript helpers
function! Trim(str)
    return substitute(a:str, '^\s*\(.\{-}\)\s*\n*$', '\1', '')
endfunction

function! SetLSPShortcuts()
  map <buffer> <leader>u :call LanguageClient#textDocument_definition()<CR>
  map <buffer> <leader>r :call LanguageClient#textDocument_rename()<CR>
  map <buffer> <leader>t :call LanguageClient#textDocument_typeDefinition()<CR>
  map <buffer> <leader>x :call LanguageClient#textDocument_references()<CR>
  map <buffer> <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  map <buffer> <F3> :call LanguageClient#textDocument_formatting()<CR>
  map <buffer> <C-n> :call LanguageClient#textDocument_completion()<CR>
  map <buffer> <C-h> :call LanguageClient#textDocument_hover()<CR>
  map <buffer> <C-s>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  map <buffer> <C-m>lm :call LanguageClient_contextMenu()<CR>
endfunction()
