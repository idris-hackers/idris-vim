scriptencoding utf-8

if exists('g:loaded_idris_vim')
  finish
endif
let g:loaded_idris_vim = 1

let g:idris_vim_enable_keymappings_by_default = get(g:, 'idris_vim_enable_keymappings_by_default', 1)
