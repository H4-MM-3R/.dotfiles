return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({})
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local capabilities_new = require('cmp_nvim_lsp').default_capabilities(capabilities)
            capabilities.offsetEncoding = 'utf-8'

            require('lspconfig').lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },

                        workspace = {
                            checkThirdParty = false,
                        },
                    }
                }
            })
            require('lspconfig').jdtls.setup({
                capabilities = capabilities,
            })
            require('lspconfig').bashls.setup({
                capabilities = capabilities,
            })
            require('lspconfig').pyright.setup({
                capabilities = capabilities,
            })
            require('lspconfig').yamlls.setup({
                capabilities = capabilities,
            })
            require('lspconfig').jsonls.setup({
                capabilities = capabilities,
            })
            require('lspconfig').clangd.setup({
                capabilities = capabilities,
            })
            require('lspconfig').tsserver.setup({
                capabilities = capabilities_new,
            })
            require('lspconfig').tailwindcss.setup({
                capabilities = capabilities_new,
            })
            require('lspconfig').cssmodules_ls.setup({
                capabilities = capabilities_new,
            })
            require('lspconfig').cssls.setup({
                capabilities = capabilities_new,
            })


        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                automatic_setup = true,
            })
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local formatter = null_ls.builtins.formatting
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
                sources = {
                    formatter.clang_format.with({
                        filetypes = {"c", "cpp", "cs"}
                    }),
                    formatter.google_java_format,
                    formatter.prettier,
                    formatter.black,

                },
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end


            cmp.setup({
                sources = {
                    {name = 'nvim_lsp'},
                    {name = 'luasnip'},
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
                            -- they way you will only jump inside the snippet region
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                formatting = {
                    format = require("lspkind").cmp_format({
                        wirth_text = false,
                        maxwidth = 50,
                    })
                }

            })
        end,
    },
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-path"},
    {"saadparwaiz1/cmp_luasnip"},
    {
        "onsails/lspkind.nvim",
        init = function()
            require("lspkind").init({
                mode = 'symbol_text',
                preset = 'codicons',
                symbol_map = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                }
            })

        end,
    },
    {
        "nvimdev/lspsaga.nvim", 
        config = function()
            require("lspsaga").setup({
                ui = {
                    winblend = 10,
                    border = 'rounded',
                    colors = {
                        normal_bg = '#002b36'
                    }
                },
                symbol_in_winbar = {
                    enable = true,
                    seperator = '/',
                    folder_level = 0,
                }
            })

        end, 
    },
}
