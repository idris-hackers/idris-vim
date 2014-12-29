if bufname('%') == "idris-response"
  finish
endif

if exists("b:did_ftplugin")
  finish
endif

setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
setlocal comments=s1:{-,mb:-,ex:-},:\|\|\|,:--
setlocal commentstring=--%s

let idris_response = 0
let b:did_ftplugin = 1

function! IdrisDocFold(lineNum)
  let line = getline(a:lineNum)

  if line =~ "^\s*|||"
    return "1"
  endif

  return "0"
endfunction

function! IdrisFold(lineNum)
  return IdrisDocFold(a:lineNum)
endfunction

setlocal foldmethod=expr
setlocal foldexpr=IdrisFold(v:lnum)

function! IdrisResponseWin()
  if (!bufexists("idris-response"))
    botright 10split
    badd idris-response
    b idris-response
    let g:idris_respwin = "active"
    set buftype=nofile
    wincmd k
  elseif (bufexists("idris-response") && g:idris_respwin == "hidden")
    botright 10split
    b idris-response
    let g:idris_respwin = "active"
    wincmd k
  endif
endfunction

function! IdrisHideResponseWin()
  let g:idris_respwin = "hidden"
endfunction

function! IdrisShowRepsonseWin()
  let g:idris_respwin = "active"
endfunction

function! IWrite(str)
  if (bufexists("idris-response"))
    b idris-response
    %delete
    let resp = split(a:str, '\n')
    call append(1, resp)
    b #
  else
    echo a:str
  endif
endfunction

function! IdrisReload(q)
  w
  let file = expand("%:p")
  let tc = system("idris --client ':l " . file . "'")
  if (! (tc is ""))
    call IWrite(tc)
  else
    if (a:q==0)
       echo "Successfully reloaded " . file
       call IWrite("")
    endif
  endif
  return tc
endfunction

function! IdrisReloadToLine(cline)
  w
  let file = expand("%:p")
  let tc = system("idris --client ':lto " . a:cline . " " . file . "'")
  if (! (tc is ""))
    call IWrite(tc)
  endif
  return tc
endfunction

function! IdrisShowType()
  w
  let word = expand("<cword>")
  let cline = line(".")
  let tc = IdrisReloadToLine(cline)
  if (! (tc is ""))
    echo tc
  else
    let ty = system("idris --client ':t " . word . "'")
    call IWrite(ty)
  endif
  return tc
endfunction

function! IdrisShowDoc()
  w
  let word = expand("<cword>")
  let ty = system("idris --client ':doc " . word . "'")
  call IWrite(ty)
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
    let fn = "idris --client ':ps! " . cline . " " . word . " " . hints . "'"
    let result = system(fn)
    if (! (result is ""))
       call IWrite(result)
    else
      e
      call winrestview(view)
    endif
  endif
endfunction

function! IdrisMakeLemma()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload(1)

  if (tc is "")
    let fn = "idris --client ':ml! " . cline . " " . word . "'"
    let result = system(fn)
    if (! (result is ""))
       call IWrite(result)
    else
      e
      call winrestview(view)
      call search(word, "b")
    endif
  endif
endfunction

function! IdrisRefine()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload(1)

  let name = input ("Name: ")

  if (tc is "")
    let fn = "idris --client ':ref! " . cline . " " . word . " " . name . "'"
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
    let fn = "idris --client ':am! " . cline . " " . word . "'"
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
  let tc = IdrisReloadToLine(cline)

  if (tc is "")
    let fn = "idris --client ':cs! " . cline . " " . word . "'"
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
    let fn = "idris --client ':mw! " . cline . " " . word . "'"
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
  let tc = IdrisReloadToLine(cline)

  if (tc is "")
    if (a:proof==0)
      let fn = "idris --client ':ac! " . cline . " " . word . "'"
    else
      let fn = "idris --client ':apc! " . cline . " " . word . "'"
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
     call IWrite(" = " . result)
  endif
endfunction

map <LocalLeader>t :call IdrisShowType()<ENTER>
map <LocalLeader>r :call IdrisReload(0)<ENTER>
map <LocalLeader>c :call IdrisCaseSplit()<ENTER>
map <LocalLeader>d 0:call search(":")<ENTER>b:call IdrisAddClause(0)<ENTER>w
map <LocalLeader>b 0w:call IdrisAddClause(0)<ENTER>
map <LocalLeader>m :call IdrisAddMissing()<ENTER>
map <LocalLeader>md 0:call search(":")<ENTER>b:call IdrisAddClause(1)<ENTER>w
map <LocalLeader>f :call IdrisRefine()<ENTER>
map <LocalLeader>o :call IdrisProofSearch(0)<ENTER>
map <LocalLeader>p :call IdrisProofSearch(1)<ENTER>
map <LocalLeader>l :call IdrisMakeLemma()<ENTER>
map <LocalLeader>e :call IdrisEval()<ENTER>
map <LocalLeader>w 0:call IdrisMakeWith()<ENTER>
map <LocalLeader>i 0:call IdrisResponseWin()<ENTER>
map <LocalLeader>h :call IdrisShowDoc()<ENTER>

menu Idris.Reload <LocalLeader>r
menu Idris.Show\ Type <LocalLeader>t
menu Idris.Evaluate <LocalLeader>e
menu Idris.-SEP0- :
menu Idris.Add\ Clause <LocalLeader>d
menu Idris.Add\ with <LocalLeader>w
menu Idris.Case\ Split <LocalLeader>c
menu Idris.Add\ missing\ cases <LocalLeader>m
menu Idris.Proof\ Search <LocalLeader>o
menu Idris.Proof\ Search\ with\ hints <LocalLeader>p

au BufHidden idris-response call IdrisHideResponseWin()
au BufEnter idris-response call IdrisShowRepsonseWin()
