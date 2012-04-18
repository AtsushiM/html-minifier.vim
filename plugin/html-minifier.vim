"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/html-minifier.vim
"VERSION:  0.9
"LICENSE:  MIT

if exists("g:loaded_html_minifier")
    finish
endif
let g:loaded_html_minifier = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=* HTMLMinifier call htmlminifier#Minifier(<f-args>)
command! -range HTMLCommentRemove <line1>,<line2>call htmlminifier#CommentRemove()

let &cpo = s:save_cpo
