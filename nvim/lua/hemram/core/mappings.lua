local opts = { noremap = true, silent = true }

-- Numbering
vim.opt.nu = true
vim.opt.rnu = true

-- Encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
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

-- Pop-Up Blending
vim.opt.pumblend = 10

-- Indentation
vim.opt.smartindent = false

-- wrapping greater than screen-size
vim.opt.wrap = false

-- file saving
vim.opt.swapfile = false
vim.opt.backup = false
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
vim.opt.signcolumn = "yes"

-- Saving time in milliseconds
vim.opt.updatetime = 50

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

-- btw, I use <M-;> for changing to Normal Mode

vim.keymap.set("n", "<Leader>ss", ":silent !tmux neww sessionizer<CR>", {})
vim.keymap.set("n", "<Leader>sc", ":silent !tmux neww config_session<CR>", {})
vim.keymap.set("n", "cn", "*``cgn", opts)
vim.keymap.set("v", "<Leader>y", '"+y', {})
vim.keymap.set("n", "<Leader>v", "ggVG", {})
vim.keymap.set("n", "<Leader>p", '"+P', { desc = "Paste from ClipBoard" })
vim.keymap.set("n", "<Leader>d", '"+d', { desc = "Delete to ClipBoard" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})
vim.keymap.set("v", "H", "^", {})
vim.keymap.set("v", "L", "$", {})
vim.keymap.set("n", "H", "^", {})
vim.keymap.set("n", "L", "$", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "n", "nzzzv", {})
vim.keymap.set("n", "N", "Nzzzv", {})
vim.keymap.set("v", "p", '"_dp', {})

-- LspSaga
vim.keymap.set("n", "<leader>lf", "<Cmd>Lspsaga finder<CR>", opts)
vim.keymap.set("n", "<leader>ls", "<Cmd>Lspsaga outline<CR>", opts)
vim.keymap.set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "<leader>ld", "<Cmd>Lspsaga show_buf_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>lp", "<Cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "<leader>lg", "<Cmd>Lspsaga goto_definition<CR>", opts)

-- WhichKey
vim.keymap.set("n", "<C-h>", "<Cmd>WhichKey<CR>", {})

-- Toggle
vim.keymap.set("n", "<Leader>t", "<Cmd>Lspsaga term_toggle<CR>", { desc = "Toggle Terminal" })
vim.keymap.set("n", "<Leader>b", "<Cmd>Telescope file_browser<CR>", { desc = "Toggle File Browser" })
vim.keymap.set("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Toggle Lazy" })
vim.keymap.set("n", "<Leader>m", "<Cmd>Mason<CR>", { desc = "Toggle Mason" })

-- Games
vim.keymap.set("n", "<leader>gv", "<Cmd>VimBeGood<CR>", {desc = "Vim be Good"})
vim.keymap.set("n", "<leader>gr", "<Cmd>CellularAutomaton make_it_rain<CR>", {desc = "Make it Rain"})
vim.keymap.set("n", "<leader>gg", "<Cmd>CellularAutomaton game_of_life<CR>", {desc = "Game of Life"})
vim.keymap.set("n", "<leader>gt", "<Cmd>Tetris<CR>", {})

-- Zen Mode
vim.keymap.set("n", "<leader>z", "<Cmd>ZenMode<CR>", {})

-- Code
vim.keymap.set({ "n", "v" }, "<Leader>ca", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set("n", "<Leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Code Format" })
vim.keymap.set("n", "<Leader>cl", "<Cmd>LspInfo<CR>", { desc = "Lsp Info" })
vim.keymap.set("n", "<Leader>cc", ":update<CR>:make<CR>", { desc = "Compile" }, opts)
vim.keymap.set("n", "<Leader>cr", ":update<CR>@g", { desc = "Run" }, opts)
vim.keymap.set("n", "<Leader>wr", "<Cmd>Lspsaga rename<CR>", { desc = "Rename" }, opts)

-- Quickfix
vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "open quickfix list" })
vim.keymap.set("n", "<leader>qq", "<cmd>cclose<CR>", { desc = "close quickfix list" })
vim.keymap.set("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "open quickfix list" })
vim.keymap.set("n", "<leader>lq", "<cmd>lclose<CR>", { desc = "close quickfix list" })

-- Notification
vim.keymap.set("n", "<leader>n", function()
    require("notify").dismiss({ silent = true, pending = true })
end, {desc = "Notify Dismiss"})

-- Harpoon for Terminal
vim.keymap.set("n", "<leader>hn", function()
    require("harpoon.tmux").gotoTerminal("{last}")
    require("harpoon.tmux").sendCommand("{last}", "ls")
end)
vim.keymap.set("n", "<leader>hc", function()
    require("harpoon.cmd-ui").toggle_quick_menu()
end)

-- Faster Navigation for me
vim.keymap.set("n", "<leader>j", "`c", { desc = "Go to Current position Mark" })
vim.keymap.set("n", "<leader>k", "`m", { desc = "Go to Marked position Mark" })

-- Luasnip select mode pasting Bug
vim.keymap.set("s", "p", function()
  vim.api.nvim_feedkeys("p", "n", false)
end, { silent = true, remap = false, desc = "Don't paste in select mode" })
