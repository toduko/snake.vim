function! InitBinds()
  call ClearUnnecessaryBinds()

  map <silent> <buffer> h :call ChangeToLeft()<CR>
  map <silent> <buffer> j :call ChangeToDown()<CR>
  map <silent> <buffer> k :call ChangeToUp()<CR>
  map <silent> <buffer> l :call ChangeToRight()<CR>
endfunction!

function! ClearUnnecessaryBinds()
  mapclear <buffer>

  for key in ['i', 'a', 'v', 'c', 'x', 'd', 'o']
    exec 'map <buffer> ' . key . ' <nop>'
    exec 'map <buffer> ' . toupper(key) . ' <nop>'
  endfor
endfunction

function! InitEditorBinds()
  map <silent> <buffer> w :call Write('#')<CR>
  map <silent> <buffer> s :call Write('*')<CR>
  map <silent> <buffer> f :call Write('o')<CR>
  map <silent> <buffer> c :call Write(' ')<CR>
endfunction

function! Write(symbol)
  echo strcharpart(getline('.')[col('.') - 1:], 0, 1)
  if index(['|', '+', '-'], strcharpart(getline('.')[col('.') - 1:], 0, 1)) >= 0
    return
  endif

  exec 'normal! r' . a:symbol
endfunction
