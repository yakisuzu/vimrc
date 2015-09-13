let g:dir_vimrc = '~/dotfiles/vim/'

function! s:load_vimrc(dir)
  exe 'source ' . g:dir_vimrc . a:dir
endfunction

call s:load_vimrc('vimrc_init.vim')
call s:load_vimrc('vimrc_neobundle.vim')
call s:load_vimrc('vimrc_base.vim')
call s:load_vimrc('vimrc_add.vim')
call s:load_vimrc('vimrc_vrapper.vim')
