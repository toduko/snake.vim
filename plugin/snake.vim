function Snake()
  call snake#Start()
endfunc

command! -nargs=0 Snake :call Snake()
