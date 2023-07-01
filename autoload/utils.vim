function RandInt(n)
  let l:seed = srand()
  return rand(l:seed) % a:n
endfunction
