return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            local status, colorizer = pcall(require, "colorizer")
            if not status then
                return
            end

            colorizer.setup({
                "*",
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local status, lualine = pcall(require, "lualine")
            if not status then
                return
            end

            local custom_solarized = require("lualine.themes.solarized_dark")

            local function show_macro_recording()
                local recording_register = vim.fn.reg_recording()
                if recording_register == "" then
                    return ""
                else
                    return "Recording @" .. recording_register
                end
            end

            vim.api.nvim_create_autocmd("RecordingEnter", {
                callback = function()
                    lualine.refresh({
                        place = { "statusline" },
                    })
                end,
            })

            vim.api.nvim_create_autocmd("RecordingLeave", {
                callback = function()
                    local timer = vim.loop.new_timer()
                    timer:start(
                        50,
                        0,
                        vim.schedule_wrap(function()
                            lualine.refresh({
                                place = { "statusline" },
                            })
                        end)
                    )
                end,
            })

            custom_solarized.normal.a.bg = "#073642"
            custom_solarized.normal.a.fg = "#eee8d5"
            custom_solarized.normal.b.bg = "#073642"
            custom_solarized.normal.b.fg = "#eee8d5"
            custom_solarized.normal.c.bg = "#002b36"
            custom_solarized.insert.a.bg = "#657b83"
            custom_solarized.visual.a.bg = "#b58900"
            custom_solarized.inactive.a.bg = "#002b36"
            custom_solarized.inactive.a.fg = "#eee8d5"

            lualine.setup({
                options = {
                    icons_enabled = true,
                    theme = custom_solarized,
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                    globalstatus = false,
                },
                sections = {
                    lualine_a = {
                        { "mode", separator = { right = "" } },
                    },
                    lualine_b = {
                        {
                            "macro-recording",
                            fmt = show_macro_recording,
                        },
                        { "branch" },
                    },
                    lualine_c = {
                        {
                            "filename",
                            file_status = true, -- displays file status (readonly status, modified status)
                            path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
                        },
                    },
                    lualine_x = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = { error = " ", warn = " ", info = " ", hint = " " },
                        },
                        {
                            'vim.fn["codeium#GetStatusString"]()',
                            fmt = function(str)
                                if str == " ON" then
                                    return " "
                                elseif str == "OFF" then
                                    return " "
                                elseif str == " * " then
                                    return " "
                                else
                                    return str
                                end
                            end,
                        },
                    },
                    lualine_y = {
                        {
                            "filetype",
                            colored = false,
                            icon_only = false,
                            icon = { align = "right" },
                        },
                    },
                    lualine_z = {
                        "location",
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        {
                            "filename",
                            file_status = true, -- displays file status (readonly status, modified status)
                            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                        },
                    },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },

                tabline = {},
                extensions = { "fugitive", "quickfix", "trouble" },
            })
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
            require("nvim-web-devicons").setup({
                default = true,
                override = {},
            })
        end,
    },
    {
        "anuvyklack/pretty-fold.nvim",
        init = function()
            require("pretty-fold").setup({
                keep_indentation = true,
                fill_char = "━",
                sections = {
                    left = {
                        "content",
                    },
                    right = {
                        "┫ ",
                        "number_of_folded_lines",
                        ": ",
                        "percentage",
                        " ┣━━━━━━━",
                    },
                },
            })
        end,
    },
    {
        "anuvyklack/fold-preview.nvim",
        dependencies = "anuvyklack/keymap-amend.nvim",
        config = function()
            local fp = require("fold-preview")
            local keymap = vim.keymap
            keymap.amend = require("keymap-amend")

            fp.setup({
                default_keybindings = false,
            })

            keymap.amend("n", "K", function(original)
                if not fp.toggle_preview() then
                    original()
                end
            end)
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = function()
            require("nvim-autopairs").setup({
                disable_filetype = { "TelescopePrompt", "vim" },
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "numToStr/Comment.nvim",
        opts = function()
            require("Comment").setup({
                opleader = {
                    line = "gc",
                    block = "gb",
                },
                mappings = {
                    basic = true,
                    extra = true,
                },
                toggler = {
                    line = "gcc",
                    block = "gbc",
                },
            })
            local comment_ft = require("Comment.ft")
            comment_ft.set("lua", { "--%s", "--[[%s]]" })
        end,
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                backdrop = 1,
                height = 0.9,
                options = {
                    number = false,
                    relativenumber = false,
                    signcolumn = "no",
                    list = false,
                    cursorline = false,
                },
            },
        },
    },
    {
        "folke/twilight.nvim",
        opts = {
            context = -1,
            treesitter = true,
        },
    },
    {
        "tpope/vim-surround",
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    progress = {
                        enabled = false,
                    },
                },
                cmdline = {
                    enabled = true,
                    view = "cmdline",
                    format = {
                        cmdline = { pattern = "^:", icon = "", land = "vim" },
                        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                        search_and_replace = {
                            kind = "search",
                            pattern = { "^:'<,'>s", "^:%%s", "^:vimgrep" },
                            icon = "󰈲",
                            lang = "regex",
                        },
                        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                        lua = {
                            pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                            icon = "",
                            lang = "lua",
                        },
                        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                    },
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                                { find = "%d+ lines yanked" },
                                { find = "W [%d+/%d+]" },
                            },
                        },
                        view = "mini",
                    },
                },
            })
        end,
    },
    {
        "thePrimeagen/harpoon",
        init = function()
            vim.keymap.set("n", "<leader>ha", function()
                require("harpoon.mark").add_file()
            end)
            vim.keymap.set("n", "<leader>hm", function()
                require("harpoon.ui").toggle_quick_menu()
            end)
            vim.keymap.set("n", "<C-p>", function()
                require("harpoon.ui").nav_prev()
            end, { desc = "Harpoon Previous" })
            vim.keymap.set("n", "<C-n>", function()
                require("harpoon.ui").nav_next()
            end, { desc = "Harpoon Next" })
        end,
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
}
