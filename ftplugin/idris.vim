setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab

let idris_response=0

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

function! IdrisResponseWin()
  if (!bufexists("idris-response"))
    10split
    badd idris-response
    b idris-response
    let b:respwin = winnr()
    set buftype=nofile
    wincmd j
  endif
endfunction

function! IWrite(str)
  if (bufexists("idris-response"))
    b idris-response
    %delete
    let resp = split(a:str, '\n')
    call append(1, resp)
    b #
  else
    echo "\n" . a:str
  endif
endfunction

function! IdrisReload(q)
  let file = expand("%")
  let tc = system("idris --client :l " . file)
  if (! (tc is ""))
    call IWrite(tc)
  else
    if (a:q==0)
       echo "Successfully reloaded " . file
    endif
  endif
  return tc
endfunction

function! IdrisShowType()
  w
  let word = expand("<cword>")
  let tc = IdrisReload(1)
  if (! (tc is ""))
    echo tc
  else
    let ty = system("idris --client :t " . word)
    call IWrite(ty)
  endif
  return tc
endfunction

function! IdrisProofSearch(hint)
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload(1)

  if (a:hint==0)
     let hints = ""
  else
     let hints = input ("Hints: ")
  endif

  if (tc is "")
    let fn = "idris --client :ps! " . cline . " " . word . " " . hints
    let result = system(fn)
    if (! (result is ""))
       call IWrite(result)
    else
      e
      call winrestview(view)
    endif
  endif
endfunction

function! IdrisAddMissing()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload(1)

  if (tc is "")
    let fn = "idris --client :am! " . cline . " " . word
    let result = system(fn)
    if (! (result is ""))
       call IWrite(result)
    else
      e
      call winrestview(view)
    endif
  endif
endfunction

function! IdrisCaseSplit()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload(1)

  if (tc is "")
    let fn = "idris --client :cs! " . cline . " " . word
    let result = system(fn)
    if (! (result is ""))
       call IWrite(result)
    else
      e
      call winrestview(view)
    endif
  endif
endfunction

function! IdrisMakeWith()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload(1)

  if (tc is "")
    let fn = "idris --client :mw! " . cline . " " . word
    let result = system(fn)
    if (! (result is ""))
       call IWrite(result)
    else
      e
      call winrestview(view)
      call search("_")
    endif
  endif
endfunction

function! IdrisAddClause(proof)
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload(1)

  if (tc is "")
    if (a:proof==0)
      let fn = "idris --client :ac! " . cline . " " . word
    else
      let fn = "idris --client :apc! " . cline . " " . word
    endif

    let result = system(fn)
    if (! (result is ""))
       call IWrite(result)
    else
      e
      call winrestview(view)
      call search(word)

    endif
  endif
endfunction

function! IdrisEval()
  let tc = IdrisReload(1)
  if (tc is "")
     let expr = input ("Expression: ")
     let fn = "idris --client '" . expr . "'"
     let result = system(fn)
     call IWrite(result)
  endif
endfunction

map <LocalLeader>t :call IdrisShowType()<ENTER>
map <LocalLeader>r :call IdrisReload(0)<ENTER>
map <LocalLeader>c :call IdrisCaseSplit()<ENTER>
map <LocalLeader>d 0/:<ENTER>b:call IdrisAddClause(0)<ENTER>w
map <LocalLeader>m :call IdrisAddMissing()<ENTER>
map <LocalLeader>md 0/:<ENTER>b:call IdrisAddClause(1)<ENTER>w
map <LocalLeader>o :call IdrisProofSearch(0)<ENTER>
map <LocalLeader>p :call IdrisProofSearch(1)<ENTER>
map <LocalLeader>e :call IdrisEval()<ENTER>
map <LocalLeader>w 0:call IdrisMakeWith()<ENTER>
map <LocalLeader>i 0:call IdrisResponseWin()<ENTER>
