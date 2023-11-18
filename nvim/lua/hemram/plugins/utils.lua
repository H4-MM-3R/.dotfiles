return {
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = function()
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
            vim.keymap.set('n', '<leader>sa', require("telescope.builtin").autocommands ,{ desc = "AutoCommands" })
            vim.keymap.set('n', '<leader>so', require("telescope.builtin").vim_options ,{ desc = "Vim_Options" })
            vim.keymap.set('n', '<leader>sd', require("telescope.builtin").diagnostics ,{ desc = "Diagnostics" })
            vim.keymap.set('n', '<leader>sh', require("telescope.builtin").highlights,{ desc = "Highlight Groups" })
            vim.keymap.set('n', '<leader>sc', require("telescope.builtin").colorscheme,{ desc = "ColorSchemes" })
        end,
        init = function()
            require("telescope").setup(
            {
                defaults = {
                    mappings = {
                        n = {
                            ["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
                            ["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
                        },
                        i = {
                            ["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
                            ["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
                        },
                    },
                    prompt_prefix = "   ",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                },
                extensions = {
                    file_browser = {
                        grouped = true,
                        hidden = { file_browser = true, folder_browser = true },
                        hijack_netrw = true,
                        theme = false,
                        hide_parent_dir = true,
                    }
                },

            }
            )
            require("telescope").load_extension "file_browser"
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {
            padding = true,
            auto_close = true,
            group = true,
        },
        init = function()
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
        end
    },
    {
        "folke/todo-comments.nvim",
        opts = {
            keywords = {
                TODO = { icon = " " },
                NOTE = { icon = "󱞁 " },
                TEST = { icon = " " },
            }
        }
    },
    {
        "tpope/vim-fugitive"
    },
}


