let s:timer = 150

function! InitEvents()
  augroup UpdateGame
    autocmd!
    autocmd CursorHold * call Update()
  augroup END

  augroup LeaveGame
    autocmd!
    autocmd BufLeave * autocmd! UpdateGame CursorHold *
  augroup END

  let &l:updatetime = s:timer
endfunction!
