function Snake()
  call snake#Start()
endfunction

function SnakeOpenEditor(rows, cols)
  call snake#OpenEditor(a:rows, a:cols)
endfunction

command! -nargs=0 Snake :call Snake()
command! -nargs=* SnakeOpenEditor :call SnakeOpenEditor(<f-args>)
