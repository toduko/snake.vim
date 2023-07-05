function RandInt(n)
  let l:seed = srand()
  return rand(l:seed) % a:n
endfunction

function SaveAndOpenNewBuffer()
  if filereadable(bufname('%'))
    exec "w"
  endif

  exec "enew"
endfunction
