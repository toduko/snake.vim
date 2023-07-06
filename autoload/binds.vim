function! InitBinds()
  mapclear <buffer>

  for key in ['i', 'a', 'v', 'c', 'x', 'd']
    exec 'map <buffer> ' . key . ' <nop>'
    exec 'map <buffer> ' . toupper(key) . ' <nop>'
  endfor

  map <silent> <buffer> h :call ChangeToLeft()<CR>
  map <silent> <buffer> j :call ChangeToDown()<CR>
  map <silent> <buffer> k :call ChangeToUp()<CR>
  map <silent> <buffer> l :call ChangeToRight()<CR>
endfunction!
