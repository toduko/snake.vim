command! -nargs=? Snake :call snake#Start(<f-args>)
command! -nargs=* SnakeOpenEditor :call snake#OpenEditor(<f-args>)
