-- Numbering 
vim.opt.nu = true
vim.opt.rnu = true

-- Encoding
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
-- Tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

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
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {})
vim.keymap.set("v", '<Leader>y', '"+y', {})
vim.keymap.set("n", '<Leader>v', 'ggVG', {})
vim.keymap.set("n", '<Leader>p', '"+P', { desc = "Paste from ClipBoard"})
vim.keymap.set("n", '<Leader>d', '"+d', { desc = "Delete to ClipBoard"})
vim.keymap.set("v", 'J', ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", 'K', ":m '<-2<CR>gv=gv", {})
vim.keymap.set("n", 'H', "^", {})
vim.keymap.set("n", 'L', "$", {})
vim.keymap.set("n", '<C-u>', "<C-u>zz", {})
vim.keymap.set("n", '<C-d>', "<C-d>zz", {})
vim.keymap.set("n", 'n', "nzzzv", {})
vim.keymap.set("n", 'N', "Nzzzv", {})
vim.keymap.set("v", 'p', '"_dp',{})
vim.keymap.set("v", 'p', '"_dp',{})

-- Harpoon
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>hm", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<C-o>", require("harpoon.ui").nav_next)
vim.keymap.set("n", "<C-i>", require("harpoon.ui").nav_prev)


-- Telescope
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fl', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>fbf', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<leader>ft', require('telescope.builtin').help_tags, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, {})
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, {})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').builtin, {})
vim.keymap.set('n', '<leader>fm', require('telescope.builtin').marks, {})
vim.keymap.set('n', '<leader>fh', "<Cmd>:Telescope harpoon marks<CR>|<C-q>" , {})


local opts = { noremap = true, silent = true }

-- LspSaga
vim.keymap.set('n', '<leader>lf', '<Cmd>Lspsaga finder<CR>', opts)
vim.keymap.set('n', '<leader>ls', '<Cmd>Lspsaga outline<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', '<leader>ld', '<Cmd>Lspsaga show_buf_diagnostics<CR>', opts)
vim.keymap.set('n', 'gp','<Cmd>Lspsaga peek_definition<CR>', opts)

-- WhichKey
vim.keymap.set('n', '<C-h>', '<Cmd>WhichKey<CR>', {})

-- Toggle
vim.keymap.set('n', '<Leader>t', '<Cmd>Lspsaga term_toggle<CR>', {desc = "Toggle Terminal"})
vim.keymap.set('n', '<Leader>b', '<Cmd>Telescope file_browser<CR>', { desc = "Toggle File Browser"})


-- Games
vim.keymap.set('n', '<leader>gv', '<Cmd>VimBeGood<CR>', {})
vim.keymap.set('n', '<leader>gr', '<Cmd>CellularAutomaton make_it_rain<CR>', {})
vim.keymap.set('n', '<leader>gg', '<Cmd>CellularAutomaton game_of_life<CR>', {})
vim.keymap.set('n', '<leader>gt', '<Cmd>Tetris<CR>', {})

-- Zen Mode
vim.keymap.set('n', '<leader>z', '<Cmd>ZenMode<CR>', {})

-- Code 
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set( 'n', '<Leader>cl', "<Cmd>LspInfo<CR>", { desc = "Lsp Info" } )
vim.keymap.set( 'n', '<Leader>cr', "<Cmd>Lspsaga rename<CR>", { desc = "Rename" }, opts )

-- Trouble
vim.keymap.set('n', '<Leader>xx', "<Cmd>TroubleToggle<CR>")
vim.keymap.set('n', '<Leader>xd', "<Cmd>TroubleToggle document_diagnostics<CR>")
vim.keymap.set('n', '<Leader>xq', "<Cmd>TroubleToggle quickfix<CR>")
vim.keymap.set('n', '<Leader>xl', "<Cmd>TroubleToggle lsp_references<CR>")
vim.keymap.set('n', "<C-J>", function ()
    if require("trouble").is_open() then
        require("trouble").previous({ skip_groups = true, jump = true })
    else
        local ok = pcall(vim.cmd.cprev)
        if not ok then
            pcall(vim.cmd.clast)
        end
    end
end, {desc = "Previous Trouble/ quickfix item"})
vim.keymap.set('n', "<C-K>", function ()
    if require("trouble").is_open() then
        require("trouble").next({skip_groups = true, jump = true })
    else
        local ok = pcall(vim.cmd.cnext)
        if not ok then
            pcall(vim.cmd.cfirst)
        end
    end
end, {desc = "Next Trouble/ quickfix item"})

