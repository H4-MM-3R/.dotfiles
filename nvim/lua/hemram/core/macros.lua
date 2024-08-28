vim.cmd([[ let @r="y:%s/\<C-r>\"//g\<Left>\<Left>" ]]) -- replace all occurences ( replaced with treesitter )
vim.cmd([[ let @t="y:'<,'>s//g\<Left>\<Left>" ]]) -- replace all occurences ( replaced with treesitter )
vim.cmd([[ let @l=":vimgrep//**\<Left>\<Left>\<left>" ]]) -- replace all occurences ( replaced with treesitter )

vim.cmd([[
          augroup CodeRunner
                  autocmd BufEnter *.java let @g=":w\<CR>:sp | terminal java %\<CR>i"
                  autocmd BufEnter *.cpp let @g=":w\<CR> :!g++ -std=c++17 -O3 -o %.exe %\<CR> | :sp |terminal ./%.exe\<CR>i"
                  " autocmd BufEnter *.cs let @g=":w\<CR> :!mcs % \<CR> | :vsp | terminal mono %:r.exe \<CR>i"
                  autocmd BufEnter *.cs let @g=":w\<CR> :sp | terminal dotnet build --no-restore && dotnet run --no-build \<CR>"
                  autocmd BufEnter *.py let @g=":w\<CR>:sp |terminal python3 %\<CR>i"
                  autocmd BufEnter *.js let @g=":w\<CR> :sp | terminal nodejs % \<CR>i"
                  autocmd BufEnter *.rs let @g=":w\<CR> :sp | terminal cargo run"
          augroup end
]])

vim.cmd([[
augroup MakePRG
autocmd FileType java setlocal makeprg=java\ %
autocmd FileType python setlocal makeprg=python\ %
autocmd FileType javascript setlocal makeprg=node\ %
augroup end
]])

-- vim.cmd [[
-- augroup RetainFolds
-- autocmd!
-- autocmd BufWinLeave *.java mkview
-- autocmd BufWinLeave *.cpp mkview
-- autocmd BufWinLeave *.js mkview
-- autocmd BufWinLeave *.jsx mkview
-- autocmd BufWinLeave *.py mkview
-- autocmd BufWinLeave *.md mkview
-- autocmd BufWinLeave *.ino mkview
-- autocmd BufWinLeave *.rs mkview
-- autocmd BufWinEnter *.java silent! loadview
-- autocmd BufWinEnter *.cpp silent! loadview
-- autocmd BufWinEnter *.js silent! loadview
-- autocmd BufWinEnter *.jsx silent! loadview
-- autocmd BufWinEnter *.py silent! loadview
-- autocmd BufWinEnter *.md silent! loadview
-- autocmd BufWinEnter *.rs silent! loadview
-- ]]

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

local group = vim.api.nvim_create_augroup("HemramAutocmds", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*.cs", "*.fs" },
	group = group,
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local line_count = vim.api.nvim_buf_line_count(buf)

		if line_count == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
			-- require("dotnet.dotnet").bootstrap_new_csharp_file()
            require("customs.csharp_init").bootstrap_new_csharp_file()
		end
	end,
})

-- Define options for keymap
local opts = { noremap = true, silent = true }

-- Create an autocommand group
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs", -- For C# files
	callback = function()
		-- Override the keymap for C# files
		vim.keymap.set("n", "<leader>lg", function()
			require("omnisharp_extended").telescope_lsp_definitions({jump_type = "vsplit"})
		end, opts)
	end,
})

vim.cmd([[
autocmd FileType markdown setlocal conceallevel=2
]])
