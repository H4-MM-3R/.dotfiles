vim.cmd [[ let @r=":%s/\<C-r>\"//g\<Left>\<Left>" ]] -- replace all occurences ( replaced with treesitter )
vim.cmd [[ let @t=":'<,'>s//g\<Left>\<Left>" ]] -- replace all occurences ( replaced with treesitter )
vim.cmd [[ let @l=":vimgrep//**\<Left>\<Left>\<left>" ]] -- replace all occurences ( replaced with treesitter )

vim.cmd [[
          augroup CodeRunner
                  autocmd BufEnter *.java let @g=":w\<CR>:sp | terminal java %\<CR>i"
                  autocmd BufEnter *.cpp let @g=":w\<CR> :!g++ -std=c++17 -O3 -o %.exe %\<CR> | :sp |terminal ./%.exe\<CR>i"
                  autocmd BufEnter *.py let @g=":w\<CR>:sp |terminal python3 %\<CR>i"
                  autocmd BufEnter *.js let @g=":w\<CR> :sp | terminal nodejs % \<CR>i"
                  autocmd BufEnter *.rs let @g=":w\<CR> :sp | terminal cargo run"
          augroup end
]]

vim.cmd [[ 
augroup MakePRG
autocmd FileType java setlocal makeprg=java\ % 
autocmd FileType python setlocal makeprg=python\ % 
autocmd FileType javascript setlocal makeprg=node\ % 
augroup end
]]

vim.cmd [[ 
augroup RetainFolds
autocmd!
autocmd BufWinLeave *.java mkview
autocmd BufWinLeave *.cpp mkview
autocmd BufWinLeave *.js mkview
autocmd BufWinLeave *.jsx mkview
autocmd BufWinLeave *.py mkview
autocmd BufWinLeave *.md mkview
autocmd BufWinLeave *.ino mkview
autocmd BufWinLeave *.rs mkview
autocmd BufWinEnter *.java silent! loadview
autocmd BufWinEnter *.cpp silent! loadview
autocmd BufWinEnter *.js silent! loadview
autocmd BufWinEnter *.jsx silent! loadview
autocmd BufWinEnter *.py silent! loadview
autocmd BufWinEnter *.md silent! loadview
autocmd BufWinEnter *.rs silent! loadview
]]


vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
    end,
})

vim.cmd [[
autocmd FileType markdown setlocal conceallevel=2
]]


