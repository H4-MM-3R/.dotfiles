local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Numbering
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.showtabline = 1
vim.opt.syntax = "on"

-- Encoding
vim.opt.fileencoding = "utf-8"

-- Tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- RigGrep for grep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true

-- Confirm
vim.opt.confirm = true

-- CursorLine
vim.opt.cursorline = true

-- Indentation
vim.opt.smartindent = true

-- wrapping greater than screen-size
vim.opt.wrap = false

-- file saving
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Mode Show
vim.opt.showmode = true
vim.opt.cmdheight = 1

-- Minimum Scroll-length
vim.opt.scrolloff = 8

-- Sign-Column
vim.opt.signcolumn = "yes:2"
vim.opt.statuscolumn = ""

--highlight 80 columns after text-width
vim.colorcolumn = "80"

-- Leader Key
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.splitbelow = true

--############################################################
--######################## KEYMAPS ###########################
--############################################################

-- Best keymaps for me

map("i", "<M-;>", "<Esc>", { desc = "Insert to Normal Mode" })

map("n", "<Leader>ss", ":silent !tmux neww sessionizer<CR>", { desc = "Sessionizer" })
map("t", "<M-;>", "<C-\\><C-n>", { desc = "Terminal to Normal Mode" })
map("n", "<Leader>sc", ":silent !tmux neww config_session<CR>", { desc = "Config" })
map("n", "<leader>sd", ":silent !tmux neww erase_sessions<CR>", { desc = "Switcher" })
map("n", "<leader>sl", ":silent !tmux neww learn_session<CR>", { desc = "Learn" })
map("n", "cn", "*``cgn", opts)
map("v", "<Leader>y", '"+y', { desc = "Yank to Clipboard" })
map("n", "<Leader>v", "ggVG", { desc = "Select All" })
map("n", "<Leader>p", '"+P', { desc = "Paste from ClipBoard" })
map("v", "p", "_dp", { desc = "Preserve [p]aste Mode" })
map("v", "P", "_dP", { desc = "Preserve [P]aste Mode" })
map("v", "J", ":m '>+1<CR>gv=gv", {})
map("v", "K", ":m '<-2<CR>gv=gv", {})
map("n", "H", "^", {})
map("n", "L", "$", {})
map("v", "H", "^", {})
map("v", "L", "$", {})
map("s", "H", "H", {})
map("s", "L", "L", {})
map("n", "<C-u>", "<C-u>zz", {})
map("n", "<C-d>", "<C-d>zz", {})
map("n", "n", "nzzzv", {})
map("n", "N", "Nzzzv", {})
map("v", "p", '"_dp', {})

-- LspSaga
map("n", "<leader>lf", "<Cmd>Lspsaga finder<CR>", opts)
-- map("n", "<leader>ls", "<Cmd>Lspsaga outline<CR>", opts)
-- map("n", "<leader>ls", "<Cmd>Telescope lsp_document_symbols<CR>", opts)
map("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
map("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "<leader>ld", "<Cmd>Lspsaga show_buf_diagnostics<CR>", opts)
map("n", "<leader>lp", "<Cmd>Lspsaga peek_definition<CR>", opts)
map("n", "<leader>lg", "<Cmd>Lspsaga goto_definition<CR>", opts)

-- Toggle
-- map("n", "<Leader>t", "<Cmd>Lspsaga term_toggle<CR>", { desc = "Toggle Terminal" })
-- map("n", "<Leader>b", "<Cmd>Telescope file_browser<CR>", { desc = "Toggle File Browser" })
-- map("n", "<Leader>ll", "<Cmd>Lazy<CR>", { desc = "Toggle Lazy" })
map("n", "<Leader>ll", "<Cmd>LspLog<CR>", { desc = "Toggle lsp logs" })
map("n", "<Leader>m", "<Cmd>Mason<CR>", { desc = "Toggle Mason" })

-- Games
map("n", "<leader>gv", "<Cmd>VimBeGood<CR>", { desc = "Vim be Good" })
map("n", "<leader>gr", "<Cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it Rain" })
map("n", "<leader>gg", "<Cmd>CellularAutomaton game_of_life<CR>", { desc = "Game of Life" })
map("n", "<leader>gt", "<Cmd>Tetris<CR>", {})

-- Zen Mode
map("n", "<leader>z", "<Cmd>ZenMode<CR>", {})

-- Code
map({ "n", "v" }, "<Leader>ca", "<cmd>Lspsaga code_action<CR>")
map("n", "<Leader>cf", function()
	require("conform").format()
end, { desc = "Code Format" })
map("n", "<Leader>cl", "<Cmd>LspInfo<CR>", { desc = "Lsp Info" })
map("n", "<Leader>cc", ":update<CR>:make<CR>", { desc = "Compile" })
map("n", "<Leader>cr", ":update<CR>@g", { desc = "Run" })
map("n", "<Leader>wr", "<Cmd>Lspsaga rename<CR>", { desc = "Rename" })

-- NeoTest
map("n", "]t", "<Cmd>Neotest jump next<CR>", { desc = "NeoTest Jump to Next Test case" })
map("n", "[t", "<Cmd>Neotest jump prev<CR>", { desc = "NeoTest Jump to Previous Test case" })
map("n", "<leader>tt", "<Cmd>Neotest run<CR>", { desc = "NeoTest Run Tests" })
map("n", "<leader>ts", "<Cmd>Neotest summary<CR>", { desc = "NeoTest Test Summary" })

-- Quickfix
map("n", "<leader>qo", "<cmd>copen<CR>", { desc = "open quickfix list" })
map("n", "<leader>qq", "<cmd>cclose<CR>", { desc = "close quickfix list" })

-- Notification
-- map("n", "<leader>n", function()
-- 	require("noice").cmd("dismiss")({ silent = true, pending = true })
-- end, { desc = "Notify Dismiss" })

-- Harpoon for Terminal
for i = 1, 5 do
	map("n", "<leader>c" .. i, function()
		require("lua.customs.cmdrunner_window").run_harpoon_cmd(i)
	end, { desc = "Harpoon Run Command on a Window " .. i })
end

for i = 1, 5 do
	map("n", "<leader>h" .. i, function()
		require("recon.cmd-runner").run_recon_cmd(i)
	end, { desc = "Recon Run Command " .. i })
end

map("n", "<leader>rc", function()
	require("recon.cmd-ui").toggle_quick_menu()
end, { desc = "Recon Terminal Command Menu" })

-- Luasnip select mode pasting Bug
map("s", "p", function()
	vim.api.nvim_feedkeys("p", "n", false)
end, { silent = true, remap = false, desc = "Don't paste in select mode" })

map("n", "<leader>lr", "<Cmd>luafile %<CR>", { desc = "Lua file Runner" })

map("n", "<leader>al", ":silent Leet list<CR>", { desc = "LeetCode List" })
map("n", "<leader>at", ":silent Leet test<CR>", { desc = "LeetCode Test" })
map("n", "<leader>ad", ":silent Leet submit<CR>", { desc = "LeetCode Submit" })
map("n", "<leader>ac", ":silent Leet console<CR>", { desc = "LeetCode Console" })
map("n", "<leader>ai", ":silent Leet info<CR>", { desc = "LeetCode Information" })

map("n", ",<leader>", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
	vim.cmd.startinsert()
end)

map({ "n", "t" }, "<M-h>", "<CMD>NavigatorLeft<CR>")
map({ "n", "t" }, "<M-l>", "<CMD>NavigatorRight<CR>")
map({ "n", "t" }, "<M-k>", "<CMD>NavigatorUp<CR>")
map({ "n", "t" }, "<M-j>", "<CMD>NavigatorDown<CR>")

local function trim(str)
	str = str:gsub("^%s*(.-)%s*$", "%1")

	if string.sub(str, -1, -1) == "." then
		str = string.sub(str, 1, -2)
		str = str:gsub("^%s*(.-)%s*$", "%1")
	end

	return str
end

vim.diagnostic.config({
	virtual_text = true,
	float = {
		border = "rounded",
		format = function(diagnostic)
			return trim(diagnostic.message)
		end,
		prefix = function(diagnostic, i, total)
			local hl = "Comment"
			local prefix = total > 1 and ("%d. "):format(i) or ""

			if diagnostic.source then
				prefix = ("%s%s: "):format(prefix, trim(diagnostic.source))
			end

			return prefix, hl
		end,
		win_options = {
			conceallevel = 2,
			concealcursor = "n",
			winhighlight = "NormalFloat:Normal,FloatBorder:Normal",
		},
	},
})

map("n", "<Leader>i", "<Cmd>Inspect<CR>", opts)
