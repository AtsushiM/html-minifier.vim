"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/html-minifier.vim
"VERSION:  0.9
"LICENSE:  MIT

function! htmlminifier#CommentRemove()
    let line = getline('.')
    let end = 0
    let ret = ''

    while end == 0
        let i = matchlist(line, '\v(.{-})\<\!\-\-(.{-})\-\-\>(.*)')

        if i != []
            let min = i[1]

            let j = matchlist(i[2], '\v^(\[if)(.{-})(\[endif\])')
            if j != []
                let min = min.'<!--'.i[2].'-->'
            endif

            let ret = ret.min
            let line = i[3]
        else
            let ret = ret.line
            let end = 1
        endif
    endwhile

    call setline('.', ret)
endfunction

function! htmlminifier#Minifier(...)
    let output = ''
    let input = ''

    if a:0 != 0
        for e in a:000
            let eary = split(e,'=')
            if eary[0] == '-input'
                let input = eary[1]
            elseif eary[0] == '-output'
                let output = eary[1]
            endif
        endfor
    endif

    if input == ''
        let input = expand('%')
    endif
    if output == ''
        let output = fnamemodify(input, ':p:r').'.min.'.fnamemodify(input, ':e')
    endif

    " TODO: 特定のファイル名を保存した場合に自動ミニファイ
    " TODO: 行末スペースは纏めて削除
    " remove return & indent
    let html = readfile(input)
    let ret = ''
    for e in html
        let i = matchlist(e, '\v^(\s*)(.*)')
        if i != []
            let ret = ret.i[2]
        endif
    endfor

    " remove space
    let end = 0
    let min = ''
    while end == 0
        let i = matchlist(ret, '\v(.{-})(\s+)(.*)')

        if i != []
            let min = min.i[1].' '
            let ret = i[3]
        else
            let min = min.ret
            let end = 1
        endif
    endwhile
    let ret = min

    " remove comment
    let end = 0
    let min = ''
    while end == 0
        let i = matchlist(ret, '\v(.{-})\<\!\-\-(.{-})\-\-\>(.*)')

        if i != []
            let min = min.i[1]

            let j = matchlist(i[2], '\v^(\[if)(.{-})(\[endif\])')

            if j != []
                let min = min.'<!--'.i[2].'-->'
            endif

            let ret = i[3]
        else
            let min = min.ret
            let end = 1
        endif
    endwhile
    let ret = min

    " remove program comment
    let end = 0
    let min = ''
    while end == 0
        let i = matchlist(ret, '\v(.{-})/\*.{-}\*/(.*)')
        if i != []
            let min = min.i[1]
            let ret = i[2]
        else
            let min = min.ret
            let end = 1
        endif
    endwhile
    let ret = min

    call writefile([ret], output)
endfunctio
