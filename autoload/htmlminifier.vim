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

    echo ret
    call setline('.', ret)
endfunction
function! htmlminifier#Minifier()
    " remove return & indent
    let html = readfile(expand('%'))
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

    call system('echo -e "'.min.'" > '.expand('%:p:r').'.min.'.expand('%:e'))
endfunctio
