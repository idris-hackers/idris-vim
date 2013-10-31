setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

function! IdrisReload(q)
  let file = expand("%")
  let tc = system("idris --client :l " . file)
  if (! (tc is ""))
    echo tc
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
    echo ty
  endif
  return tc
endfunction

function! IdrisProofSearch()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload(1)

  if (tc is "")
    let fn = "idris --client :ps! " . cline . " " . word
    let result = system(fn)
    if (! (result is ""))
       echo result
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
       echo result
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
       echo result
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
       echo result
    else
      e
      call winrestview(view)
      call search("_")
    endif
  endif
endfunction

function! IdrisAddClause()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload(1)

  if (tc is "")
    let fn = "idris --client :ac! " . cline . " " . word
    let result = system(fn)
    if (! (result is ""))
       echo result
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
     echo " = " . result
  endif
  echo ""
endfunction

map <LocalLeader>t :call IdrisShowType()<ENTER>
map <LocalLeader>r :call IdrisReload(0)<ENTER>
map <LocalLeader>c :call IdrisCaseSplit()<ENTER>
map <LocalLeader>d ?:<ENTER>b:call IdrisAddClause()<ENTER>w
map <LocalLeader>m :call IdrisAddMissing()<ENTER>
map <LocalLeader>o :call IdrisProofSearch()<ENTER>
map <LocalLeader>e :call IdrisEval()<ENTER>
map <LocalLeader>w 0:call IdrisMakeWith()<ENTER>
