local opts = { noremap = true, silent = true }


-- function _G.custom_fold_text()
--     local line = vim.fn.getline(vim.v.foldstart)
--     local line_count = vim.v.foldend - vim.v.foldstart + 1
--
--     return line .. "  " .. line_count .. " lines"
-- end
--
-- vim.opt.foldtext = 'v:lua.custom_fold_text()'

-- Numbering 
vim.opt.nu = true
vim.opt.rnu = true

-- vim.cmd[[colorscheme solarized-osaka]]
-- Encoding
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

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
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {})

vim.keymap.set("n", 'cn', '*``cgn', opts)
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



-- Harpoon
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>hm", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>[", require("harpoon.ui").nav_next, { desc = "Harpoon Next" })
vim.keymap.set("n", "<leader>]", require("harpoon.ui").nav_prev, { desc = "Harpoon Previous" })


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
vim.keymap.set('n', '<leader>fh', "<Cmd>:Telescope harpoon marks<CR><C-Q>" , {})

-- Telescope Search
vim.keymap.set('n', '<leader>sa', require("telescope.builtin").autocommands ,{ desc = "AutoCommands" })
vim.keymap.set('n', '<leader>so', require("telescope.builtin").vim_options ,{ desc = "Vim_Options" })
vim.keymap.set('n', '<leader>sd', require("telescope.builtin").diagnostics ,{ desc = "Diagnostics" })
vim.keymap.set('n', '<leader>sh', require("telescope.builtin").highlights,{ desc = "Highlight Groups" })
vim.keymap.set('n', '<leader>sc', require("telescope.builtin").colorscheme,{ desc = "ColorSchemes" })


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
vim.keymap.set( 'n', '<Leader>cc', ":update<CR>:make<CR>", { desc = "Compile" }, opts )
vim.keymap.set( 'n', '<Leader>cr', ":update<CR>@g", { desc = "Run" }, opts )
vim.keymap.set( 'n', '<Leader>wr', "<Cmd>Lspsaga rename<CR>", { desc = "Rename" }, opts )

-- Trouble
vim.keymap.set('n', '<Leader>xx', "<Cmd>TroubleToggle<CR>")
vim.keymap.set('n', '<Leader>xd', "<Cmd>TroubleToggle document_diagnostics<CR>")
vim.keymap.set('n', '<Leader>xq', "<Cmd>TroubleToggle quickfix<CR>")
vim.keymap.set('n', '<Leader>xl', "<Cmd>TroubleToggle lsp_references<CR>")
vim.keymap.set('n', '<Leader>xt', "<Cmd>TodoTrouble<CR>", { desc = "TODO" })
vim.keymap.set('n', "<c-j>", function ()
    if require("trouble").is_open() then
        require("trouble").previous({ skip_groups = true, jump = true })
    else
        local ok = pcall(vim.cmd.cprev)
        if not ok then
            pcall(vim.cmd.clast)
       end
    end
end, {desc = "previous trouble/ quickfix item"})
vim.keymap.set('n', "<c-k>", function ()
    if require("trouble").is_open() then
        require("trouble").next({skip_groups = true, jump = true })
    else
        local ok = pcall(vim.cmd.cnext)
        if not ok then
            pcall(vim.cmd.cfirst)
        end
    end
end, {desc = "next trouble/ quickfix item"})


-- Quickfix
vim.keymap.set('n', '<leader>qo', "<cmd>copen<CR>", {desc = "open quickfix list"})
vim.keymap.set('n', '<leader>qq', "<cmd>cclose<CR>", {desc = "close quickfix list"})
vim.keymap.set('n', '<leader>lo', "<cmd>lopen<CR>", {desc = "open quickfix list"})
vim.keymap.set('n', '<leader>lq', "<cmd>lclose<CR>", {desc = "close quickfix list"})


vim.keymap.set('n', "<c-i>", function ()
        local ok = pcall(vim.cmd.lprev)
        if not ok then
            pcall(vim.cmd.llast)
       end
end, {desc = "previous locationlist item"})

vim.keymap.set('n', "<c-o>", function ()
        local ok = pcall(vim.cmd.lnext)
        if not ok then
            pcall(vim.cmd.lfirst)
        end
end, {desc = "next locationlist item"})


-- Notify
vim.keymap.set('n', '<leader>n', function ()
    require("notify").dismiss({ silent = true, pending = true })
end)
