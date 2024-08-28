return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
			"nvimdev/lspsaga.nvim",
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"saadparwaiz1/cmp_luasnip",
			"jay-babu/mason-nvim-dap.nvim",
			"rafamadriz/friendly-snippets",
			"jose-elias-alvarez/null-ls.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			"rcarriga/nvim-dap-ui",
		},
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
			-- require("lspconfig").cssmodules_ls.setup({
			-- 	capabilities = capabilities_new,
			-- 	handlers = handlers,
			-- })
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
			require("lspconfig").omnisharp.setup({
				capabilities = capabilities_new,
				handlers = {
					["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
					["textDocument/signatureHelp"] = vim.lsp.with(
						vim.lsp.handlers.signature_help,
						{ border = "rounded" }
					),
					["textDocument/definition"] = vim.lsp.with(require("omnisharp_extended").definition_handler),
					["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
					["textDocument/references"] = require("omnisharp_extended").references_handler,
					["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
				},
				enable_roslyn_analysers = true,
				enable_import_completion = true,
				organize_imports_on_format = true,
				enable_decompilation_support = true,
				filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
				cmd = { "dotnet", "/home/hemram/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
			})
			-- require("lspconfig").jdtls.setup({
			-- 	capabilities = capabilities_new,
			-- 	handlers = handlers,
			-- })
			-- require("lspconfig").solidity_ls.setup({
			-- 	capabilities = capabilities_new,
			-- 	handlers = handlers,
			-- })

			require("mason").setup({
				ui = {
					keymaps = {
						apply_language_filter = "f?",
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"omnisharp",
					"jdtls",
					"bashls",
					"pyright",
					"yamlls",
					"jsonls",
					"clangd",
					"tailwindcss",
					"lemminx",
					"cssls",
					"tsserver",
					"emmet_language_server",
					"lua_ls",
				},
			})
			local dap = require("dap")
			require("dapui").setup({
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.25,
							},
							{
								id = "breakpoints",
								size = 0.25,
							},
							{
								id = "stacks",
								size = 0.25,
							},
							{
								id = "watches",
								size = 0.25,
							},
						},
						position = "right",
						size = 40,
					},
					{
						elements = {
							{
								id = "repl",
								size = 0.5,
							},
							{
								id = "console",
								size = 0.5,
							},
						},
						position = "bottom",
						size = 20,
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				local bufnr = vim.api.nvim_get_current_buf()
				local breakpoints = require("dap.breakpoints").get(bufnr)
				local itemslength = breakpoints[bufnr]
				if #itemslength == 0 then
					require("dapui").float_element("console")
				else
					require("dapui").open(1)
					require("dapui").open(2)
				end
			end

			dap.configurations.java = {
				{
					type = "java",
					request = "launch",
					name = "Debug Launch (2GB)",
					program = "${file}",
				},
			}

			dap.adapters.coreclr = {
				type = "executable",
				command = "/home/hemram/.local/share/nvim/mason/bin/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}

			local keymap = vim.keymap
			keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
			keymap.set(
				"n",
				"<leader>bc",
				"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>"
			)
			keymap.set(
				"n",
				"<leader>bl",
				"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>"
			)
			keymap.set("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>")
			keymap.set("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>")
			keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
			keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
			keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
			keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
			keymap.set("n", "<leader>dd", function()
				require("dap").disconnect()
				require("dapui").close()
			end)
			keymap.set("n", "<leader>dt", function()
				require("dap").terminate()
				require("dapui").close()
			end)
			keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
			keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
			keymap.set("n", "<leader>di", function()
				require("dap.ui.widgets").hover()
			end)
			keymap.set("n", "<leader>d?", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end)
			keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>")
			keymap.set("n", "<leader>dh", "<cmd>Telescope dap commands<cr>")
			keymap.set("n", "<leader>de", function()
				require("telescope.builtin").diagnostics({ default_text = ":E:" })
			end)

			local null_ls = require("null-ls")
			local formatter = null_ls.builtins.formatting

			null_ls.setup({
				sources = {
					formatter.clang_format.with({
						filetypes = { "c", "cpp" },
					}),
					formatter.google_java_format,
					formatter.prettier.with({
						extra_filetypes = { "graphql", "solidity" },
					}),
					formatter.black,
					formatter.xmlformat,
					formatter.stylua,
					formatter.csharpier,
				},
			})
			require("luasnip.loaders.from_vscode").lazy_load()
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
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-test, java-debug-adapter" },
			})
		end,
	},
}
