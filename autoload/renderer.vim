function! DrawBorders(rows, cols)
  normal! ggdG
  let l:space = "|"
  let l:border = "+"

  let l:i = 1

  while l:i <= a:cols
    let l:space = l:space . " "
    let l:border = l:border . "-"
    let l:i = l:i + 1
  endwhile

  let l:space = l:space . "|"
  let l:border = l:border . "+"
  let l:i = 1

  call setline(1, l:border) 

  while l:i <= a:rows
    call append(line('$'), l:space)
    let l:i = l:i + 1
  endwhile

  call append(line('$'), l:border)
endfunction!

function! DrawStatus(started, game_over, score)
  if a:started == 0
    call append(line('$'), "Press hjkl and the game will begin")
  elseif a:game_over == 0
    call append(line('$'), "Score: " . a:score)
  else
    call append(line('$'), "Game over! Score: " . a:score)
  endif
endfunction!

function! DrawWalls(walls)
  for [x, y] in a:walls
    call cursor(y + 2, x + 2)
    normal! r#
  endfor
endfunction!

function! DrawSnake(snake)
  for [x, y] in a:snake
    call cursor(y + 2, x + 2)
    normal! r*
  endfor
endfunction!

function! DrawFood(food)
  call cursor(a:food[1] + 2, a:food[0] + 2)
  normal! ro
endfunction!
