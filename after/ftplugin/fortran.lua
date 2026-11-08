-- gfortran messages (multi-line, with caret markers) for :make / quickfix
vim.cmd([[setlocal errorformat=%-Ggfortran%.%#,%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\ %m,%Z%tarning:\ %m,%Z%tote:\ %m,%C%.%#,%-G%.%#]])
