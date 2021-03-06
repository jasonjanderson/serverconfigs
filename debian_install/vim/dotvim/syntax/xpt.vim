" =========================================
" XPTemplate command to define snippet file 
" =========================================

fun! s:GetMark()

    let cur = [ line( '.' ), col( '.' ) ]


    call cursor( 0, 0 )
    let lnr = search( '^XPTemplate .*mark=..', 'c' )

    if lnr == 0
        call cursor ( cur )
        return ['`', '^', '`^']
    endif

    let line = getline( lnr )

    let marks = matchstr( line, '\Vmark=\zs\.\.' )

    call cursor ( cur )
    return [ marks[0:0], marks[1:1], marks ]
    
endfunction




setlocal foldmethod=syntax


syntax keyword  XPTemplateSnippetKey XPTemplate nextgroup=XPTfileMeta skipwhite

syntax region   XPTfileMeta               start=/./ end=/$/ contained
syntax match    XPTfileMetaPair           /\w\+=\S*/ containedin=XPTfileMeta

" meta data values
syntax match    XPTfileMetaValue_keyword  /=\S*/ containedin=XPTfileMetaPair
syntax match    XPTfileMetaValue_mark     /=\S\{2}/ containedin=XPTfileMetaPair
syntax match    XPTfileMetaValue_indent   /=\%(auto\|keep\|\%(\/\d\+\)\?\*\d\+\)/ containedin=XPTfileMetaPair
syntax match    XPTfileMetaValue_priority /=\%(all\|spec\|like\|lang\|sub\|personal\)\?\%([+-]\d*\)\?/ containedin=XPTfileMetaPair

" meta data keys 
syntax keyword  XPTfileMetaKey_priority   prio[rity] containedin=XPTfileMetaPair nextgroup=XPTfileMetaValue_priority
syntax keyword  XPTfileMetaKey_keyword    key[word] containedin=XPTfileMetaPair nextgroup=XPTfileMetaValue_keyword
syntax keyword  XPTfileMetaKey_mark       mark containedin=XPTfileMetaPair nextgroup=XPTfileMetaValue_mark
syntax keyword  XPTfileMetaKey_indent     ind[ent] containedin=XPTfileMetaPair nextgroup=XPTfileMetaValue_indent


" ==================================
" XPTvar command to define variables
" ==================================
syntax match    XptVarValue  /.*$/ containedin=XptVarBody
syntax region   XptVarBody matchgroup=XptVarName start=/\$\w\+/ end=/$/ keepend skipwhite nextgroup=XptVarValue
syntax keyword  XPTSnippetVar XPTvar nextgroup=XptVarBody skipwhite


" ==================
" XPTinclude command
" ==================
syntax match    XptSnippetIncludeItemDir /\%(\w\+\/\)\+/ containedin=XptSnippetIncludeItem
syntax match    XptSnippetIncludeItemFile /[a-zA-Z0-9_.]\+\s*$/ containedin=XptSnippetIncludeItem
syntax match    XptSnippetIncludeItem /\w\+\/.*/ containedin=XptSnippetIncludeBody
syntax region   XptSnippetIncludeBody start=/^\s*\\/ end=/^\ze\s*[^\\	]/ keepend skipwhite
syntax keyword  XptSnippetInclude     XPTinclude nextgroup=XptSnippetIncludeBody skipnl skipwhite



" =======================
" Xpt snippets definition
" =======================
" use the max priority to find the XPTemplateDef
syntax keyword  XPTemplateDefStartKey XPTemplateDef nextgroup=XPTregion skipnl skipempty skipwhite
syntax region   XPTregion start=/^/ end=/\%$/ contained contains=XPTsnippetTitle




" TODO escaping
syntax match XPTvariable /\$\w\+/ containedin=XPTmeta_value,XPTxset_value
syntax match XPTvariable_quote /{\$\w\+}/ containedin=XPTmeta_value,XPTxset_value

" TODO escaping, quoted
syntax region XPTfunction start=/\w\+(/ end=/)/ containedin=XPTmeta_value,XPTxset_value


" the end pattern is weird.
" \%(^$)^XPT\s does not work.
syntax region XPTsnippetBody  start=/^/ end=/\ze\%(^$\n\)*\%$\|\ze\%(^$\n\)*XPT\s\|^\ze\.\.XPT/ contained containedin=XPTsnippetTitle contains=XPTxset excludenl fold
" syntax region XPTsnippetBody  start=/^/ end=/\%$/ contained containedin=XPTsnippetTitle contains=XPTxset  fold
" syntax region XPTsnippetBody  start=/^/ end=/$\n^\zeXPT\s/ contained containedin=XPTsnippetTitle contains=XPTxset  fold
" syntax region XPTsnippetBody  start=/^/ end=/\ze\.\.XPT/ contained containedin=XPTsnippetTitle contains=XPTxset  fold
syntax match XPTxset /^XSET\s\+\%(\w\|[.?*]\)\+\([|.]\%(pre\|def\|post\)\)\?=.*/ containedin=XPTsnippetBody
syntax region XPTxsetm start=/^XSETm\s\+/ end=/XSETm END$/ containedin=XPTsnippetBody fold
syntax keyword XPTkeyword_XSET XSET containedin=XPTxset nextgroup=XPTxset_name1,XPTxset_name2,XPTxset_name3 skipwhite transparent
" priorities are low to high
syntax match XPTxset_value /.*/ containedin=XPTxset transparent
syntax match XPTxset_eq /=/ containedin=XPTxset nextgroup=XPTxset_value transparent
syntax match XPTxset_type /[|.]\%(pre\|def\|post\)\|\ze=/ containedin=XPTxset nextgroup=XPTxset_eq transparent
syntax match XPTxset_name3 /\%(\w\|\.\)*/ containedin=XPTxset nextgroup=XPTxset_type transparent
syntax match XPTxset_name2 /\%(\w\|\.\)*\ze\./ containedin=XPTxset nextgroup=XPTxset_type transparent
syntax match XPTxset_name1 /\%(\w\|\.\)*\ze|/ containedin=XPTxset nextgroup=XPTxset_type transparent

syntax match    XPTsnippetTitle /^XPT\s\+.*$/ containedin=XPTregion nextgroup=XPTsnippetBody skipnl skipempty
syntax keyword  XPTkeyword_XPT XPT containedin=XPTsnippetTitle nextgroup=XPTsnippetName skipwhite
syntax match    XPTsnippetName /\S\+/ containedin=XPTsnippetTitle nextgroup=XPTmeta skipwhite

" syntax match    XPTsnippetBeforeTitle /^$/ containedin=XPTregion nextgroup=XPTsnippetTitle skipnl skipempty

" escaped white space or non-space
syntax match XPTmeta /\(\\\s\|\S\)\+/ containedin=XPTsnippetTitle nextgroup=XPTmeta skipwhite
syntax match XPTmeta_name /\w\+\ze=/ containedin=XPTmeta nextgroup=XPTmeta_value
syntax match XPTmeta_value /=\zs\(\\\s\|\S\)*/ containedin=XPTmeta
" syntax match XPTcomment /^"\%(\s\|"\)*[^"]*$/ containedin=XPTregion
syntax match XPTcomment /^".*$/ containedin=XPTregion

syntax match XPTbadIndent /^\(    \)* \{1,3}\ze\%(\S\|$\)/ contained containedin=XPTsnippetBody
syntax match XPTbadIndent /^\s*\t/ contained containedin=XPTsnippetBody


" TODO mark may be need escaping in regexp
let s:m = s:GetMark()

exe 'syntax match XPTitemPost /\V\%(\[^' . s:m[2] . ']\|\(\\\*\)\1\\\[' . s:m[2] . ']\)\*\[^\\' . s:m[2] . ']' . s:m[1] . '\{1,2}/ contains=XPTmark containedin=XPTsnippetBody'
exe 'syntax match XPTitem /\V' . s:m[0] . '\%(\_[^' . s:m[1] . ']\)\{-}' . s:m[1] . '/ contains=XPTmark containedin=XPTsnippetBody nextgroup=XPTitemPost'

      " \%(\%([^`^]\|\(\\*\)\1\\\^\)*\^\)\?
" syntax match XPTmark /`\|\^/ contained


syntax keyword TemplateKey XSETm indent hint syn priority containedin=XPTsnippetTitle


hi link XPTfileMetaPair           Normal
hi link XPTfileMetaKey_priority   Identifier
hi link XPTfileMetaValue_priority Constant
hi link XPTfileMetaKey_keyword    Identifier
hi link XPTfileMetaValue_keyword  Constant
hi link XPTfileMetaKey_mark       Identifier
hi link XPTfileMetaValue_mark     Constant
hi link XPTfileMetaKey_indent       Identifier
hi link XPTfileMetaValue_indent     Constant

hi link XptVarBody            Error
hi link XptVarName            Constant
hi link XptVarValue           Normal

hi link XptSnippetIncludeItemFile String
hi link XptSnippetIncludeItemDir Directory
hi link XptSnippetIncludeItem Directory
hi link XptSnippetIncludeBody Normal
hi link XptSnippetInclude     Statement


hi link XPTemplateDefStartKey Special
hi link XPTsnippetTitle       Statement
hi link XPTsnippetName        Label
hi link XPTmeta               Normal
hi link XPTmeta_name          Identifier
hi link XPTmeta_value         String
hi link XPTsnippetBody        Normal
hi link XPTcomment            Comment
hi link XPT_END               Folded
hi link XPTxset               Comment
hi link XPTxsetm              Comment
" hi link XPTxset_name1         Function
" hi link XPTxset_name2         Function
" hi link XPTxset_name3         Function
hi link XPTxset_type          Constant
hi link XPTxset_eq            Operator
hi link XPTxset_value         Normal
hi link XPTregion             SpecialKey
hi link XPTitem               CursorLine
hi link XPTitemPost           WildMenu
hi link XPTvariable           Constant
hi link XPTvariable_quote     Constant
hi link XPTfunction           Function

hi link XPTbadIndent          Error

" not implemented
hi link XPTmark               Title
hi link TemplateKey           Title


hi link XPTemplateSnippetKey  Statement
hi link XPTSnippetVar         Statement
hi link XPTkeyword_XPT        Statement
" hi link XPTkeyword_XSET       Comment
" hi link XPTkeyword_XSET       Preproc
hi link XPTkeyword_hint       Statement


" vim: set ts=8 sw=4 sts=4 noexpandtab:
