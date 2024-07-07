return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					keymaps = {
						apply_language_filter = "f?",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"jdtls",
					"rust_analyzer",
					"bashls",
					"pyright",
					"yamlls",
					"jsonls",
					"clangd",
					"tailwindcss",
					"cssmodules_ls",
					"lemminx",
					"cssls",
					"tsserver",
					"emmet_language_server",
					"lua_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities_new = require("cmp_nvim_lsp").default_capabilities(capabilities)
			capabilities.offsetEncoding = "utf-8"

			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}

			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},

						workspace = {
							checkThirdParty = false,
						},
					},
				},
				handlers = handlers,
			})
			require("lspconfig").rust_analyzer.setup({
				capabilities = capabilities_new,
				handlers = handlers,
			})
			require("lspconfig").bashls.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			require("lspconfig").yamlls.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			require("lspconfig").jsonls.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			require("lspconfig").clangd.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			require("lspconfig").tsserver.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			require("lspconfig").tailwindcss.setup({
				capabilities = capabilities_new,
				handlers = handlers,
			})
			require("lspconfig").cssmodules_ls.setup({
				capabilities = capabilities_new,
				handlers = handlers,
			})
			require("lspconfig").lemminx.setup({
				capabilities = capabilities_new,
				handlers = handlers,
			})
			require("lspconfig").cssls.setup({
				capabilities = capabilities_new,
				handlers = handlers,
			})
			require("lspconfig").emmet_language_server.setup({
				capabilities = capabilities_new,
				handlers = handlers,
			})
			-- require("lspconfig").jdtls.setup({
			-- 	capabilities = capabilities_new,
			-- 	handlers = handlers,
			-- })
			require("lspconfig").solidity_ls.setup({
				capabilities = capabilities_new,
				handlers = handlers,
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
				ensure_installed = {
					"google_java_format",
					"prettier",
					"black",
					"xmlformat",
					"stylua",
				},
				automatic_setup = true,
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatter = null_ls.builtins.formatting

			null_ls.setup({
				sources = {
					formatter.clang_format.with({
						filetypes = { "c", "cpp", "cs" },
					}),
					formatter.google_java_format,
					formatter.prettier.with({
						extra_filetypes = { "graphql", "solidity" },
					}),
					formatter.black,
					formatter.xmlformat,
					formatter.stylua,
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
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{
						name = "buffer",
						get_buffers = function()
							return vim.api.nvim_list_bufs()
						end,
						priority = 1,
						max_item_count = 5,
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
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
							fallback(fallback)
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
						with_text = true,
						maxwidth = 50,
					}),
				},
				sorting = {
					priority_weight = 2,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
			cmp.setup.cmdline("/", {
				sources = {
					{ name = "buffer", max_item_count = 10 },
				},
			})
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{
		"onsails/lspkind.nvim",
		init = function()
			require("lspkind").init({
				mode = "symbol_text",
				preset = "codicons",
				symbol_map = {
					Array = " ",
					Boolean = "󰨙 ",
					Class = " ",
					Codeium = "󰘦 ",
					Color = " ",
					Control = " ",
					Collapsed = " ",
					Constant = "󰏿 ",
					Constructor = " ",
					Copilot = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Folder = " ",
					Function = "󰊕 ",
					Interface = " ",
					Key = " ",
					Keyword = " ",
					Method = "󰊕 ",
					Module = " ",
					Namespace = "󰦮 ",
					Null = " ",
					Number = "󰎠 ",
					Object = " ",
					Operator = " ",
					Package = " ",
					Property = " ",
					Reference = " ",
					Snippet = " ",
					String = " ",
					Struct = "󰆼 ",
					TabNine = "󰏚  ",
					Text = " ",
					TypeParameter = " ",
					Unit = " ",
					Value = " ",
					Variable = "󰀫 ",
				},
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				ui = {
					winblend = 10,
					border = "rounded",
					colors = {
						normal_bg = "#002b36",
					},
				},
				lightbulb = {
					virtual_text = false,
				},
				symbol_in_winbar = {
					enable = true,
					seperator = "/",
					folder_level = 0,
				},
				outline = {
					win_width = 30,
				},
			})
		end,
	},
	{ "thePrimeagen/refactoring.nvim" },
}
