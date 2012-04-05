"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/html-minifier.vim
"VERSION:  0.9
"LICENSE:  MIT

command! -nargs=* HTMLMinifier call htmlminifier#Minifier(<f-args>)
command! -range HTMLCommentRemove <line1>,<line2>call htmlminifier#CommentRemove()
