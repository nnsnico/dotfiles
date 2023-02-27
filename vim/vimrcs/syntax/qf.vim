if exists('b:current_syntax')
    finish
endif

let error = luaeval('require("constants").diagnostic_icons.error')
let warn  = luaeval('require("constants").diagnostic_icons.warn')
let info  = luaeval('require("constants").diagnostic_icons.info')
let note  = luaeval('require("constants").diagnostic_icons.hint')

syntax match qfFileName       /^[^│]*/ nextgroup=qfSeparatorLeft
syntax match qfSeparatorLeft  /│/      contained nextgroup=qfLineNr
syntax match qfLineNr         /[^│]*/  contained nextgroup=qfSeparatorRight
syntax match qfSeparatorRight '│'      contained nextgroup=qfError,qfWarning,qfInfo,qfNote

execute('syntax match qfError'   .. ' / ' .. error .. ' .*$/ contained')
execute('syntax match qfWarning' .. ' / ' .. warn  .. ' .*$/ contained')
execute('syntax match qfInfo'    .. ' / ' .. info  .. ' .*$/ contained')
execute('syntax match qfNote'    .. ' / ' .. note  .. ' .*$/ contained')

highlight default link qfFileName       Directory
highlight default link qfSeparatorLeft  Delimiter
highlight default link qfSeparatorRight Delimiter
highlight default link qfLineNr         Normal
highlight default link qfError          DiagnosticError
highlight default link qfWarning        DiagnosticWarn
highlight default link qfInfo           DiagnosticInfo
highlight default link qfNote           DiagnosticHint
highlight default link QuickFixLine     None

let b:current_syntax = 'qf'
