let s:path = expand('<sfile>:p:h')

let s:imports = ['utils', 'binds', 'events', 'renderer', 'highlight']

for import in s:imports
  exec 'source' . s:path . '/' . import . '.vim'
endfor

function! snake#OpenEditor(rows, cols)
  call SaveAndOpenNewBuffer()
  call ClearUnnecessaryBinds()
  call InitHighlight()
  call InitEditorBinds()
  call DrawBorders(a:rows, a:cols)
  highlight link food WarningMsg
endfunction!

pyx import vim
exec 'pyxfile' s:path . '/../pythonx/level.py'

function! OpenLevel(level_path)
  pyx vim.command("let l:valid = '%s'" % is_valid_level(vim.eval("a:level_path")))

  if l:valid == 'False'
    echo "Invalid level: " . a:level_path
    return 1
  endif 

  pyx rows, cols, snake, food, walls = get_level_data(vim.eval("a:level_path"))
  pyx vim.command("let s:rows = eval('%s')" % rows)
  pyx vim.command("let s:cols = eval('%s')" % cols)
  pyx vim.command("let s:snake = eval('%s')" % snake)
  pyx vim.command("let s:food = eval('%s')" % food)
  pyx vim.command("let s:walls = eval('%s')" % walls)

  return 0
endfunction!

function! snake#Start( ... )
  if a:0 == 0
    let l:level_path = s:path . '/../default_level.txt'
  else
    let l:level_path = a:1
  endif

  if OpenLevel(l:level_path) == 1
    return
  endif

  call SaveAndOpenNewBuffer()

  let s:started = 0
  let s:on_timeout = 0
  let s:score = 0
  let s:direction = ""
  let s:game_over = 0

  call InitHighlight()
  call InitEvents()
  call InitBinds()
endfunction!

function! ChangeToLeft()
  let s:started = 1
  if s:direction != "right" && s:on_timeout == 0
    let s:direction = "left"
    let s:on_timeout = 1
  endif
endfunction!

function! ChangeToDown()
  let s:started = 1
  if s:direction != "up" && s:on_timeout == 0
    let s:direction = "down"
    let s:on_timeout = 1
  endif
endfunction!

function! ChangeToUp()
  let s:started = 1
  if s:direction != "down" && s:on_timeout == 0
    let s:direction = "up"
    let s:on_timeout = 1
  endif
endfunction!

function! ChangeToRight()
  let s:started = 1
  if s:direction != "left" && s:on_timeout == 0
    let s:direction = "right"
    let s:on_timeout = 1
  endif
endfunction!

function! UpdateSnakeCoords()
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
    let x = s:cols - 1
  elseif x == s:cols
    let x = 0
  elseif y < 0
    let y = s:rows - 1
  elseif y == s:rows
    let y = 0
  endif

  for [w_x, w_y] in s:walls
    if x == w_x && y == w_y
      let s:game_over = 1
    endif
  endfor

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
endfunction!

function! Update()
  if s:game_over == 1
    return
  endif

  if s:started == 1
    call UpdateSnakeCoords()
  endif

  let s:on_timeout = 0

  call DrawBorders(s:rows, s:cols)
  call DrawStatus(s:started, s:game_over, s:score)
  call DrawWalls(s:walls)
  call DrawSnake(s:snake)
  call DrawFood(s:food)
endfunction!

function! ResetFood()
  let [x, y] = [RandInt(s:cols), RandInt(s:rows)]

  while index(s:snake, [x, y]) >= 0 || index(s:walls, [x, y]) >= 0
    let [x, y] = [RandInt(s:cols), RandInt(s:rows)]
  endwhile

  let s:food = [x, y]
endfunction!
