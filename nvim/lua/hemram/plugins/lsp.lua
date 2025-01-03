return {
	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities_new = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
			-- require("lspconfig").rust_analyzer.setup({
			-- 	capabilities = capabilities_new,
			-- 	handlers = handlers,
			-- })
			require("lspconfig").bashls.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			-- require("lspconfig").yamlls.setup({
			-- 	capabilities = capabilities,
			-- 	handlers = handlers,
			-- })
			require("lspconfig").jsonls.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			require("lspconfig").clangd.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			-- require("lspconfig").ts_ls.setup({
			-- 	capabilities = capabilities,
			-- 	handlers = handlers,
			-- 	settings = {
			-- 		-- Ref: https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
			-- 		preferences = {
			-- 			quotePreference = "double",
			-- 			includeCompletionsWithSnippetText = true,
			-- 			generateReturnInDocTemplate = true,
			-- 			includeInlayParameterNameHints = "all",
			-- 			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			-- 			includeInlayFunctionParameterTypeHints = true,
			-- 			includeInlayVariableTypeHints = true,
			-- 			includeInlayPropertyDeclarationTypeHints = true,
			-- 			includeInlayFunctionLikeReturnTypeHints = true,
			-- 			includeInlayEnumMemberValueHints = true,
			-- 		},
			-- 		typescript = {
			-- 			inlayHints = {
			-- 				includeInlayParameterNameHints = "all",
			-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			-- 				includeInlayFunctionParameterTypeHints = true,
			-- 				includeInlayVariableTypeHints = true,
			-- 				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
			-- 				includeInlayPropertyDeclarationTypeHints = true,
			-- 				includeInlayFunctionLikeReturnTypeHints = true,
			-- 				includeInlayEnumMemberValueHints = true,
			-- 			},
			-- 		},
			-- 		javascript = {
			-- 			inlayHints = {
			-- 				includeInlayParameterNameHints = "all",
			-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			-- 				includeInlayFunctionParameterTypeHints = true,
			-- 				includeInlayVariableTypeHints = true,
			-- 				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
			-- 				includeInlayPropertyDeclarationTypeHints = true,
			-- 				includeInlayFunctionLikeReturnTypeHints = true,
			-- 				includeInlayEnumMemberValueHints = true,
			-- 			},
			-- 		},
			-- 	},
			-- })
			require("lspconfig").vtsls.setup({
				capabilities = capabilities_new,
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
			-- require("lspconfig").lemminx.setup({
			-- 	capabilities = capabilities_new,
			-- 	handlers = handlers,
			-- })
			require("lspconfig").cssls.setup({
				capabilities = capabilities_new,
				handlers = handlers,
			})
			require("lspconfig").emmet_language_server.setup({
				capabilities = capabilities_new,
				handlers = handlers,
			})
			-- require("lspconfig").omnisharp.setup({
			-- 	capabilities = capabilities_new,
			-- 	handlers = {
			-- 		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
			-- 		["textDocument/signatureHelp"] = vim.lsp.with(
			-- 			vim.lsp.handlers.signature_help,
			-- 			{ border = "rounded" }
			-- 		),
			-- 		["textDocument/definition"] = vim.lsp.with(require("omnisharp_extended").definition_handler),
			-- 		["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
			-- 		["textDocument/references"] = require("omnisharp_extended").references_handler,
			-- 		["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
			-- 	},
			-- 	enable_roslyn_analysers = true,
			-- 	enable_import_completion = true,
			-- 	organize_imports_on_format = true,
			-- 	enable_decompilation_support = true,
			-- 	filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
			-- 	cmd = { "dotnet", "/home/hemram/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
			-- })
			-- require("lspconfig").angularls.setup({
			-- 	on_attach = function(client)
			-- 		client.server_capabilities.renameProvider = false
			-- 	end,
			-- 	capabilities = capabilities_new,
			-- 	handlers = handlers,
			-- 	cmd = angular_cmd,
			-- 	on_new_config = function(new_config)
			-- 		new_config.cmd = angular_cmd
			-- 	end,
			-- })
			require("lspconfig").gopls.setup({
				capabilities = capabilities_new,
				handlers = handlers,
				cmd = { "gopls" },
			})
			-- require("lspconfig").jdtls.setup({
			-- 	capabilities = capabilities_new,
			-- 	handlers = handlers,
			-- })
			-- require("lspconfig").solidity_ls.setup({
			-- 	capabilities = capabilities_new,
			-- 	handlers = handlers,
			-- })
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
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
					"ts_ls",
					"emmet_language_server",
					"lua_ls",
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			require("dapui").setup({
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.80,
							},
							{
								id = "breakpoints",
								size = 0.20,
							},
						},
						position = "right",
						size = 40,
					},
					{
						elements = {
							{
								id = "repl",
								size = 0.25,
							},
							{
								id = "console",
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
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "/home/hemram/.local/share/nvim/mason/packages/codelldb/codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.cpp = {
				{
					type = "codelldb",
					name = "Launch file",
					request = "launch",
					program = function()
						return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
				{
					type = "codelldb",
					request = "attach",
					name = "Attach to process",
					pid = require("dap.utils").pick_pid,
					cwd = "${workspaceFolder}",
				},
			}
		end,
		keys = function()
			local keymap = vim.keymap
			keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
			keymap.set("n", "<leader>da", "<cmd>Telescope dap list_breakpoints<cr>")
			keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
			keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
			keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
			keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
			keymap.set("n", "<leader>dd", function()
				require("dap").disconnect()
				require("dapui").close()
			end)
			keymap.set("n", "<leader>di", function()
				require("dap.ui.widgets").hover()
			end)
			keymap.set("n", "<leader>d?", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end)
			keymap.set("n", "<leader>dh", "<cmd>Telescope dap commands<cr>")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "LazyFile",
		config = function()
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
					formatter.gofmt,
					formatter.goimports_reviser,
					formatter.shfmt,
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("luasnip.loaders.from_vscode").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("cmp").setup({
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
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({ select = true })
							end
						else
							fallback()
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.jumpable(1) then
							luasnip.jump(1)
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
					["<C-n>"] = cmp.mapping(function()
						luasnip.jump(1)
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function()
						luasnip.jump(-1)
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
				-- sorting = {
				-- 	priority_weight = 2,
				-- },
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
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LazyFile",
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
					enable = false,
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
	{
		"folke/lazydev.nvim",
		ft = "lua",
	},
}
