function InitHighlight()
  syntax match snake "\*"
  syntax match food "o"
  syntax match wall "|\|+\|-\|#"
  syntax match score "Score: .*"
  syntax match over "Game over!"

  highlight link snake Identifier
  highlight link food Error
  highlight link wall Comment
  highlight link score Constant
  highlight link over Title

  setlocal nocursorline
  setlocal buftype=nofile
endfunction
