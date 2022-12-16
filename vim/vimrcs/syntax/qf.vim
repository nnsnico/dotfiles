if exists('b:current_syntax')
    finish
endif

let error = execute('echon "\uF1E2"')
let warn  = execute('echon "\uF071"')
let info  = execute('echon "\uF05A"')
let note  = execute('echon "\uFB4E"')

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
