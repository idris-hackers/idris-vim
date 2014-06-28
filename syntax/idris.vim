" syntax highlighting for idris (idris-lang.org)
"
" Heavily modified version of the haskell syntax
" highlighter to support idris.
"
" author: raichoo (raichoo@googlemail.com)

if exists("b:current_syntax")
  finish
endif

syn keyword idrisModule module namespace
syn keyword idrisImport import
syn keyword idrisRefl refl
syn keyword idrisStructure class codata data instance where record dsl
syn keyword idrisVisibility public abstract private
syn keyword idrisBlock parameters mutual postulate using
syn keyword idrisAnnotation total partial covering auto impossible static implicit
syn keyword idrisStatement do case of rewrite let in with
syn match idrisSyntax "\(pattern \+\|term \+\)\?syntax"
syn keyword idrisConditional if then else
syn match idrisTactic contained "\<\(intros\?\|rewrite\|exact\|refine\|trivial\|let\|focus\|try\|compute\|solve\|attack\|reflect\|fill\|applyTactic\)\>"
syn match idrisNumber "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
syn match idrisFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
syn match idrisDelimiter  "[(),;[\]{}]"
syn keyword idrisInfix prefix infix infixl infixr
syn match idrisOperators "\([-!#$%&\*\+./<=>\?@\\^|~:]\|\<_\>\)"
syn match idrisType "\<\([A-Z][a-zA-Z0-9_]*\|_|_\)\>"
syn keyword idrisTodo TODO FIXME XXX HACK contained
syn match idrisLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=idrisTodo,@Spell
syn match idrisDocComment "|||\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=idrisTodo,@Spell
syn match idrisMetaVar "?[a-z][A-Za-z0-9_]\+'*"
syn match idrisLink "%\(lib\|link\|include\)"
syn match idrisDirective "%\(access\|assert_total\|default\|elim\|error_reverse\|hide\|name\|reflection\|error_handlers\|language\|flag\|dynamic\|provide\)"
syn keyword idrisDSL lambda variable index_first index_next
syn match idrisChar "'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'"
syn match idrisBacktick "`[A-Za-z][A-Za-z0-9_]*\('\)*`"
syn region idrisString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
syn region idrisBlockComment start="{-" end="-}" contains=idrisBlockComment,idrisTodo,@Spell
syn region idrisProofBlock start="\(default\s\+\)\?\(proof\|tactics\) *{" end="}" contains=idrisTactic
syn match idrisIdentifier "^\s*[a-zA-Z][a-zA-z0-9_]*\('\)*" contained
syn match idrisTopLevelDecl "^\s*[a-zA-Z][a-zA-z0-9_]*\('\)*\s\+:\s\+" contains=idrisIdentifier,idrisOperators

highlight def link idrisIdentifier Identifier
highlight def link idrisImport Structure
highlight def link idrisModule Structure
highlight def link idrisStructure Structure
highlight def link idrisStatement Statement
highlight def link idrisDSL Statement
highlight def link idrisBlock Statement
highlight def link idrisAnnotation Statement
highlight def link idrisSyntax Statement
highlight def link idrisVisibility Statement
highlight def link idrisConditional Conditional
highlight def link idrisProofBlock Macro
highlight def link idrisRefl Macro
highlight def link idrisTactic Identifier
highlight def link idrisLink Statement
highlight def link idrisDirective Statement
highlight def link idrisNumber Number
highlight def link idrisFloat Float
highlight def link idrisDelimiter Delimiter
highlight def link idrisInfix PreProc
highlight def link idrisOperators Operator
highlight def link idrisType Include
highlight def link idrisDocComment Comment
highlight def link idrisLineComment Comment
highlight def link idrisBlockComment Comment
highlight def link idrisTodo Todo
highlight def link idrisMetaVar Macro
highlight def link idrisString String
highlight def link idrisChar String
highlight def link idrisBacktick Operator

let b:current_syntax = "idris"
