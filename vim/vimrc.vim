let g:dir_vimrc = '~/dotfiles/vim/'

function! g:Load_vimrc(file)
  exe 'source ' . g:dir_vimrc . a:file
endfunction

call g:Load_vimrc('vimrc_init.vim')
call g:Load_vimrc('vimrc_neobundle.vim')
call g:Load_vimrc('vimrc_base.vim')
call g:Load_vimrc('vimrc_add.vim')
call g:Load_vimrc('vimrc_vrapper.vim')