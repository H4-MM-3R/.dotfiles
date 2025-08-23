vim.cmd([[ let @r="y:%s/\<C-r>\"//g\<Left>\<Left>" ]]) -- replace all occurences ( replaced with treesitter )
vim.cmd([[ let @t="y:'<,'>s//g\<Left>\<Left>" ]]) -- replace all occurences ( replaced with treesitter )
vim.cmd([[ let @l=":vimgrep//**\<Left>\<Left>\<left>" ]]) -- replace all occurences ( replaced with treesitter )

vim.cmd([[
          augroup CodeRunner
                  autocmd BufEnter *.java let @g=":sp | terminal java %\<CR>i"
                  autocmd BufEnter *.c let @g=":sp |terminal clang % -o %< && ./%<\<CR>i"
                  autocmd BufEnter *.cs let @g=":sp | terminal dotnet build --debug --no-restore && dotnet run --no-build \<CR>"
                  autocmd BufEnter *.py let @g=":sp |terminal python3 %\<CR>i"
                  autocmd BufEnter *.js let @g=":sp | terminal nodejs % \<CR>i"
                  autocmd BufEnter *.rs let @g=":sp | terminal cargo run"
                  autocmd BufEnter *.go let @g=":sp | terminal go run %\<CR>i"
                  autocmd BufEnter *.cpp let @g=":sp |terminal runner %\<CR>i"
          augroup end
]])

vim.cmd([[
augroup MakePRG
autocmd FileType cpp setlocal makeprg=clang++\ -static\ --debug\ -DLOCAL\ -Wall\ -std=c++17\ -o\ %:r\ %
autocmd FileType java setlocal makeprg=java\ %
autocmd FileType python setlocal makeprg=python\ %
autocmd FileType javascript setlocal makeprg=node\ %
augroup end
]])

vim.cmd([[
augroup MarkdownConceal
  autocmd!
  autocmd FileType markdown setlocal conceallevel=0
  autocmd InsertEnter * setlocal conceallevel=2
  autocmd InsertLeave * setlocal conceallevel=0
augroup END
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

-- local group = vim.api.nvim_create_augroup("HemramAutocmds", { clear = true })

-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	pattern = { "*.cs", "*.fs" },
-- 	group = group,
-- 	callback = function()
-- 		local buf = vim.api.nvim_get_current_buf()
-- 		local line_count = vim.api.nvim_buf_line_count(buf)
--
-- 		if line_count == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
-- 			-- require("dotnet.dotnet").bootstrap_new_csharp_file()
-- 			require("lua.customs.csharp-init").bootstrap_new_csharp_file()
-- 		end
-- 	end,
-- })

-- Define options for keymap
-- local opts = { noremap = true, silent = true }

-- Create an autocommand group
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "cs", -- For C# files
-- 	callback = function()
-- 		-- Override the keymap for C# files
-- 		vim.keymap.set("n", "<leader>lg", function()
-- 			require("omnisharp_extended").telescope_lsp_definitions({ jump_type = "vsplit" })
-- 		end, opts)
-- 	end,
-- })

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
