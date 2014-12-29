command! VrapperrcUpdate call g:Vrapperrc_write()
function! g:Vrapperrc_write()
  let st_file = fnamemodify('~/_vrapperrc', ':p')
  let li_line = [
        \   '"update:' . strftime('%Y%m%d_%H%M')
        \ , 'set clipboard=unnamed'
        \ , 'set ignorecase'
        \ , ''
        \ , 'map <C-j> <Esc>'
        \ , 'noremap <Space>h ^'
        \ , 'noremap <Space>j <C-f>'
        \ , 'noremap <Space>k <C-b>'
        \ , 'noremap <Space>l $'
        \ , 'vnoremap * y/<C-r>0<CR>N'
        \ , 'vnoremap <Space>/ :s///g<Left><Left>'
        \ , 'inoremap <C-j> <Esc>'
        \ , 'nnoremap Y y$'
        \ , 'nnoremap tg gT'
        \ , 'nnoremap zl 20zl'
        \ , 'nnoremap zh 20zh'
        \ , 'nnoremap Q :bd<CR>'
        \ , 'nnoremap * yiw/<C-r>0<CR>N'
        \ , 'nnoremap <Space>/ :%s///g<Left><Left>'
        \ , 'nnoremap <Space>o o<Esc>'
        \ , 'nnoremap <C-]> g<C-]>'
        \ , ''
        \ , 'command So source ' . st_file
        \ , ''
        \ , '"http://help.eclipse.org/juno/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/ui/texteditor/IWorkbenchActionDefinitionIds.html'
        \ , '"http://help.eclipse.org/juno/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/ui/texteditor/ITextEditorActionDefinitionIds.html'
        \ , '"http://help.eclipse.org/juno/topic/org.eclipse.jdt.doc.isv/reference/api/org/eclipse/jdt/ui/actions/IJavaEditorActionDefinitionIds.html'
        \ ]
  call writefile(li_line, st_file)
endfunction

