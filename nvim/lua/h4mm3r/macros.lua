vim.cmd [[ let @r="\y:%s/\<C-r>\"//g\<Left>\<Left>" ]] -- replace all occurences ( replaced with treesitter )
vim.cmd [[ let @t="\y:'<,'>s//g\<Left>\<Left>" ]] -- replace all occurences ( replaced with treesitter )
vim.cmd [[ let @l=":vimgrep//**\<Left>\<Left>\<left>" ]] -- replace all occurences ( replaced with treesitter )


vim.cmd [[
          augroup code_runner
                  autocmd BufEnter *.java let @g=":w\<CR>:sp | terminal java %\<CR>i"
                  autocmd BufEnter *.cpp let @g=":w\<CR> :!g++ -std=c++17 -O3 -o %.exe %\<CR> | :sp |terminal ./%.exe\<CR>i"
                  autocmd BufEnter *.py let @g=":w\<CR>:sp |terminal python3 %\<CR>i"
                  autocmd BufEnter *.js let @g=":w\<CR> :sp | terminal node % \<CR>i"
          augroup end
]]

vim.cmd [[ 
       augroup FiletypeConfig
             autocmd FileType java setlocal makeprg=java\ % 
             autocmd FileType python setlocal makeprg=python\ % 
       augroup end
]]

vim.cmd [[ 
        autocmd!
        autocmd BufWinLeave *.* mkview
        autocmd BufWinEnter *.* silent! loadview
]]


vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
  end,
})

