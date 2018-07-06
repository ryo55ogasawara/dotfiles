" -------------------
" 元ファイル 
" -------------------
if filereadable( $HOME . "/.vimrc.orig" )
  source ~/.vimrc.orig
endif
"if filereadable( $HOME . "/.vimrc.emacs" )
"  source ~/.vimrc.emacs
"endif

" -------------------
" vim-ruby/rails
" -------------------
"<C-Space>でomni補完
imap <C-Space> <C-x><C-o>

" Ruby on Railsモードへの布石
filetype on
filetype indent on
filetype plugin on

"" Ruby mode
au FileType ruby :set nowrap tabstop=2 tw=0 sw=2 expandtab
au FileType html :set nowrap tabstop=2 tw=0 sw=2

" オムニ補完
"let g:rubycomplete_buffer_loading = 1
"let g:rubycomplete_classes_in_global = 1
"let g:rubycomplete_rails = 1


" -------------------
" auto reload .vimrc
" -------------------
"augroup source-vimrc
"  autocmd!
"  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
"  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
"augroup END

" -------------------
" auto comment off
" -------------------
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" -------------------
" HTML/XML閉じタグ自動補完
" -------------------
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" -------------------
" 編集箇所のカーソルを記憶
" -------------------
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set wrap
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif


" -------------------
" 個別設定ファイル 
" -------------------
if filereadable( $HOME . "/.vimrc.mine" )
  source ~/.vimrc.mine
endif

set tags=~/tags
