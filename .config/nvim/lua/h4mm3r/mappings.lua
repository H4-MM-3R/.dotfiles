-- Numbering 
vim.opt.nu = true
vim.opt.relativenumber = true

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
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.opt.termguicolors = true
vim.opt.splitbelow = true

--############################################################
--######################## KEYMAPS ###########################
--############################################################

-- Bufferline
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

-- Harpoon
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>hm", require("harpoon.ui").toggle_quick_menu)

-- Telescope
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fl', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, {})
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').current_buffer_fuzzy_find, {})

-- WhichKey
vim.keymap.set('n', '<C-h>', '<Cmd>WhichKey<CR>', {})

--Telescope-File-Browser
vim.keymap.set('n', '<Leader>b', '<Cmd>Telescope file_browser<CR>', {})

-- Games
vim.keymap.set('n', '<leader>gv', '<Cmd>VimBeGood<CR>', {})
vim.keymap.set('n', '<leader>gr', '<Cmd>CellularAutomaton make_it_rain<CR>', {})
vim.keymap.set('n', '<leader>gg', '<Cmd>CellularAutomaton game_of_life<CR>', {})

-- Zen Mode

vim.keymap.set('n', '<leader>z', '<Cmd>ZenMode<CR>', {})



