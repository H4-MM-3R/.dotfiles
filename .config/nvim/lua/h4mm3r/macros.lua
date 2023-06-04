vim.cmd [[ let @r="\y:%s/\<C-r>\"//g\<Left>\<Left>" ]] -- replace all occurences ( replaced with treesitter )

vim.cmd [[
          augroup code_runner
                  autocmd BufEnter *.java let @g=":w\<CR>:sp | terminal java %\<CR>i"
                  autocmd BufEnter *.cpp let @g=":w\<CR> :!g++ -std=c++17 -O3 %\<CR> | :sp |terminal ./a.out\<CR>i"
                  autocmd BufEnter *.py let @g=":w\<CR>:sp |terminal python3 %\<CR>i"
                  autocmd BufEnter *.js let @g=":w\<CR> :sp | terminal node % \<CR>i"
          augroup end
]]

