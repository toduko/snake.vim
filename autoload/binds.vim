function InitBinds()
  map <buffer> h :call ChangeToLeft()<CR>
  map <buffer> j :call ChangeToDown()<CR>
  map <buffer> k :call ChangeToUp()<CR>
  map <buffer> l :call ChangeToRight()<CR>
endfunction
