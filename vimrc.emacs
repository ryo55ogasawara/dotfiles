"カーソル一文字単位移動
inoremap <silent> <C-s> <Left>
inoremap <silent> <C-d> <Right>

"単語単位移動
inoremap <silent> <C-f> <C-r>=MyMoveWord_i('w')<CR>
inoremap <silent> <C-b> <C-r>=MyMoveWord_i('b')<CR>

"非補完時は行移動をj,kと同じ動作にして補完中は候補選択
"inoremap <silent> <expr> <C-p>  pumvisible() ? "\<C-p>" : "<C-r>=MyExecExCommand('normal k')<CR>"
"inoremap <silent> <expr> <C-n>  pumvisible() ? "\<C-n>" : "<C-r>=MyExecExCommand('normal j')<CR>"
"inoremap <silent> <expr> <Up>   pumvisible() ? "\<C-p>" : "<C-r>=MyExecExCommand('normal k')<CR>"
"inoremap <silent> <expr> <Down> pumvisible() ? "\<C-n>" : "<C-r>=MyExecExCommand('normal j')<CR>"

"行頭へ
inoremap <silent> <C-a> <C-r>=MyJumptoBol('　。、．，／！？「」')<CR>
"行末へ
inoremap <silent> <C-e> <C-r>=MyJumptoEol('　。、．，／！？「」')<CR>

"カーソル前の文字削除
inoremap <silent> <BS>  <C-g>u<BS>
inoremap <silent> <C-h> <C-g>u<C-h>
"カーソル後の文字削除
inoremap <silent> <Del> <C-g>u<Del>
inoremap <silent> <C-g> <C-g>u<Del>

"カーソル位置から前の単語を削除
inoremap <silent> <C-w> <C-g>u<C-r>=MyExecExCommand('normal! db')<CR>
"カーソル位置から後の単語を削除
inoremap <silent> <C-t> <C-g>u<C-r>=MyDeleteWord()<CR>

"最後に挿入した文字列を挿入
inoremap <silent> <C-z> <C-g>u<C-a>

"現在行をインデント
inoremap <silent> <Tab>   <C-g>u<C-t>
inoremap <silent> <S-Tab> <C-g>u<C-d>

"undo
inoremap <silent> <C-u> <C-g>u<C-r>=MyExecExCommand('u', 'onemore')<CR>

"２ストロークキー使用
if 1
  "カーソル以降削除
  inoremap <silent> <C-k><C-k> <C-g>u<C-r>=MyExecExCommand('normal! D', 'onemore')<CR>
  "redo
  "FIXME:<C-r>(リドゥ)はコマンドラインからexecで実行すると色々面倒なので回避用
  nnoremap g\\z <C-r>
  inoremap <silent> <C-k><C-r> <C-r>=MyExecExCommand('normal g\\z', 'onemore')<CR>
  "行連結
  inoremap <silent> <C-k><C-j> <C-g>u<C-r>=MyExecExCommand('normal! J')<CR>
  "新行挿入
  inoremap <silent> <C-k><C-n> <C-g>u<C-r>=MyExecExCommand("call cursor(line('.'), col('$'))")<CR><CR>
endif

"メタ(alt)キー使用
if 0
  "カーソル以降削除
  inoremap <silent> <C-k> <C-g>u<C-r>=MyExecExCommand('normal! D', 'onemore')<CR>
  "リドゥ
  "FIXME:<C-r>(リドゥ)はコマンドラインからexecで実行すると色々面倒なので回避用
  nnoremap g\\z <C-r>
  inoremap <silent> <M-r> <C-r>=MyExecExCommand('normal g\\z', 'onemore')<CR>
  "行連結
  inoremap <silent> <M-j> <C-g>u<C-r>=MyExecExCommand('normal! J')<CR>
  "新行挿入
  inoremap <silent> <M-n> <C-g>u<C-r>=MyExecExCommand("call cursor(line('.'), col('$'))")<CR><CR>
endif

""""""""""""""""""""""""""""""
"sepが空でなければ、sepをセパレータとしてジャンプ。
"見つからなければ見かけの行頭へ。
"カーソル位置が見かけの行頭の場合は真の行頭へ。
""""""""""""""""""""""""""""""
function! MyJumptoBol(sep)
  if col('.') == 1
    call cursor(line('.')-1, col('$'))
    call cursor(line('.'), col('$'))
    return ''
  endif
  if matchend(strpart(getline('.'), 0, col('.')), '[[:blank:]]\+') >= col('.')-1
    silent exec 'normal! 0'
    return ''
  endif
  if a:sep != ''
    call search('[^'.a:sep.']\+', 'bW', line("."))
    if col('.') == 1
      silent exec 'normal! ^'
    endif
    return ''
  endif
  exec 'normal! ^'
  return ''
endfunction

""""""""""""""""""""""""""""""
"sepが空でなければ、sepをセパレータとしてジャンプ。
"見つからなければ行末へ。
""""""""""""""""""""""""""""""
function! MyJumptoEol(sep)
  if col('.') == col('$')
    silent exec 'normal! w'
    return ''
  endif

  if a:sep != ''
    let prevcol = col('.')
    call search('['.a:sep.']\+[^'.a:sep.']', 'eW', line("."))
    if col('.') != prevcol
      return ''
    endif
  endif
  call cursor(line('.'), col('$'))
  return ''
endfunction

""""""""""""""""""""""""""""""
"行末でも停止する単語単位移動コマンド
""""""""""""""""""""""""""""""
function! MyMoveWord_i(cmd)
  let isEol = 0
  if col('$') == col('.')
    let isEol = 1
  endif
  let prevline = line('.')
  silent exec 'normal! '.a:cmd
  if line('.') == prevline
    return ''
  endif
  if a:cmd == 'w'
    if isEol == 0
      call cursor(prevline, 0)
      call cursor(line('.'), col('$'))
    endif
    if line('.') - prevline > 1
      call cursor(prevline+1, 0)
      call cursor(line('.'), col('$'))
    endif
  elseif a:cmd == 'b'
    call cursor(line('.'), col('$'))
    if prevline - line('.') > 1
      call cursor(prevline-1, 0)
      call cursor(line('.'), col('$'))
    endif
  endif
  return ''
endfunction

""""""""""""""""""""""""""""""
"カーソル以降の単語削除
""""""""""""""""""""""""""""""
function! MyDeleteWord()
  if col('.') == col('$')
    return ''
  endif
  let save_cursor = getpos('.')
  silent exec 'normal! wge'
  if save_cursor[1] != line('.') || (save_cursor[2] > col('.'))
    call setpos('.', save_cursor)
    return MyExecExCommand('normal! dw', 'onemore')
  endif
  silent exec 'normal! v'
  call setpos('.', save_cursor)
  return MyExecExCommand('normal! d')
endfunction

""""""""""""""""""""""""""""""
"IMEの状態とカーソル位置保存のため<C-r>を使用してコマンドを実行。
""""""""""""""""""""""""""""""
function! MyExecExCommand(cmd, ...)
  let saved_ve = &virtualedit
  let index = 1
  while index <= a:0
    if a:{index} == 'onemore'
      silent setlocal virtualedit+=onemore
    endif
    let index = index + 1
  endwhile

  silent exec a:cmd
  if a:0 > 0
    silent exec 'setlocal virtualedit='.saved_ve
  endif
  return ''
endfunction
"FIXME:<C-r>(リドゥ)はコマンドラインからexecで実行すると色々面倒なので回避用
nnoremap g\\z <C-r>

