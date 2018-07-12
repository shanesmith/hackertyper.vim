function! hackertyper#startHackerTyper()

  " mapclear
  " mapclear!
  " mapclear <buffer>
  " mapclear! <buffer>

  setlocal noautoindent
  setlocal nocindent
  setlocal nosmartindent
  setlocal indentexpr=
  setlocal buftype=nofile
  setlocal formatoptions=

  let b:hacker_typer_buffer = getline(0, "$")

  normal! gg"_dG

  let chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$%^&*()_+-=`~[]{}\'\";:/?.>,<"

  let i = 0
  while i < len(chars)
      exe "inoremap <expr> <buffer> ". chars[i] . " hackertyper#hackerChar()"
      let i += 1
  endwhile

  exe "inoremap <expr> <buffer> <Space> hackertyper#hackerChar()"
  exe "inoremap <expr> <buffer> <Tab>   hackertyper#hackerChar()"
  exe "inoremap <expr> <buffer> <BS>    hackertyper#hackerChar()"
  exe "inoremap <expr> <buffer> \\      hackertyper#hackerChar()"
  exe "inoremap <expr> <buffer> \|      hackertyper#hackerChar()"

  startinsert

endfunction

function! hackertyper#hackerChar()
  let curline = line('.')
  let curcol = col('.')

  if curline > len(b:hacker_typer_buffer)
    return ''
  elseif curline < line('$') || curcol < col('$')
    call cursor(999999999, 999999999) " last line and column
  endif

  let str = strpart(b:hacker_typer_buffer[curline-1], curcol-1, <SID>Rand())

  if str == ''
    let str = "\r"
  endif

  return str
endfun

function! s:Rand()
  let min_length = 3
  let max_length = 10

  return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]) % max_length + min_length
endfunction
