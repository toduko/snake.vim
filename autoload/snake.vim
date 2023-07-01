source binds.vim
source events.vim
source highlight.vim

function snake#Start()
  if filereadable(bufname('%'))
    exec "w"
  endif

  exec "enew"

  let s:rows = 20
  let s:cols = 50
  let s:on_timeout = 0
  let s:score = 0
  let s:direction = "right"
  let s:snake = [[10, 10]]
  let s:food = [5, 5]
  let s:game_over = 0

  call InitHighlight()
  call InitEvents()
  call InitBinds()
  call InitGame()
endfunction

function InitGame()
  let s:space = "|"
  let s:border = "+"

  let l:i = 1

  while l:i <= s:cols
    let s:space = s:space . " "
    let s:border = s:border . "-"
    let l:i = l:i + 1
  endwhile

  let s:space = s:space . "|"
  let s:border = s:border . "+"
  let l:i = 1

  call setline(line('.'), s:border) 

  while l:i <= s:rows
    call append(line('$'), s:space)
    let l:i = l:i + 1
  endwhile

  call append(line('$'), s:border)

  call append(line('$'), "Score: " . s:score)
endfunction

function ChangeToLeft()
  if s:direction != "right" && s:on_timeout == 0
    let s:direction = "left"
    let s:on_timeout = 1
  endif
endfunction

function ChangeToDown()
  if s:direction != "up" && s:on_timeout == 0
    let s:direction = "down"
    let s:on_timeout = 1
  endif
endfunction

function ChangeToUp()
  if s:direction != "down" && s:on_timeout == 0
    let s:direction = "up"
    let s:on_timeout = 1
  endif
endfunction

function ChangeToRight()
  if s:direction != "left" && s:on_timeout == 0
    let s:direction = "right"
    let s:on_timeout = 1
  endif
endfunction

function UpdateSnakeCoords()
  call feedkeys('f<esc>')

  let [x, y] = s:snake[0]

  if s:direction == "left"
    let x = x - 1
  elseif s:direction == "down"
    let y = y + 1
  elseif s:direction == "up"
    let y = y - 1
  else
    let x = x + 1
  endif

  if x < 0
    let x = s:cols
  elseif x == s:cols
    let x = 0
  elseif y < 0
    let y = s:rows
  elseif y == s:rows
    let y = 0
  endif

  if x == s:food[0] && y == s:food[1]
    let s:score = s:score + 1
    call ResetFood()
  else
    call remove(s:snake, len(s:snake) - 1)
  endif

  if index(s:snake, [x, y]) >= 0
    let s:game_over = 1
  endif

  call insert(s:snake, [x, y])
endfunction

function Update()
  if s:game_over == 1
    return
  endif

  call UpdateSnakeCoords()

  let s:on_timeout = 0

  call DrawLevel()
  call DrawSnake()
  call DrawFood()
endfunction

function DrawLevel()
  let l:i = 2

  call setline(1, s:border)

  while l:i <= s:rows + 1
    call setline(l:i, s:space)
    let l:i = l:i + 1
  endwhile

  call setline(l:i, s:border)

  let l:i = l:i + 1

  if s:game_over == 0
    call setline(l:i, "Score: " . s:score)
  else
    call setline(l:i, "Game over! Score: " . s:score)
  endif
endfunction

function DrawSnake()
  for [x, y] in s:snake
    call cursor(y + 2, x + 2)
    normal! r*
  endfor
endfunction

function DrawFood()
  call cursor(s:food[1] + 2, s:food[0] + 2)
  normal! ro
endfunction

function ResetFood()
  let [x, y] = [Rand(s:cols), Rand(s:rows)]

  while index(s:snake, [x, y]) >= 0
    let [x, y] = [Rand(s:cols), Rand(s:rows)]
  endwhile

  let s:food = [x, y]
endfunction

function Rand(n)
  let l:seed = srand()
  return rand(l:seed) % a:n
endfunction
