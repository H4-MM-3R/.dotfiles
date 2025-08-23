return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			win = {
				width = { min = 30, max = 60 },
				height = { min = 4, max = 0.75 },
				padding = { 0, 1 },
				col = -1,
				row = -1,
				border = "rounded",
				title = true,
				title_pos = "left",
			},
			layout = {
				width = { min = 30 },
			},
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			local colorizer = require("colorizer")

			colorizer.setup({
				"*",
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"craftzdog/solarized-osaka.nvim",
		},
		config = function()
			local lualine = require("lualine")

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

			local osaka = require("lualine.themes.solarized-osaka")

			osaka.normal.a.bg = "#073642"
			osaka.normal.a.fg = "#eee8d5"
			osaka.normal.b.bg = "#073642"
			osaka.normal.b.fg = "#eee8d5"
			osaka.normal.c.bg = "#002b36"
			osaka.insert.a.bg = "#657b83"
			osaka.visual.a.bg = "#b58900"
			osaka.inactive.a.bg = "#002b36"
			osaka.inactive.a.fg = "#eee8d5"

			local recon_lualine_extension = require("recon.lualine")

			lualine.setup({
				options = {
					lcons_enabled = true,
					theme = osaka,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					disabled_filetypes = {},
					always_divide_middle = true,
					globalstatus = false,
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return str:sub(1, 1)
							end,
							separator = { right = "" },
						},
					},
					lualine_b = {
						{
							"cwd",
							fmt = show_macro_recording,
						},
						{ "branch" },
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
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
							require("noice").api.status.command.get,
							cond = require("noice").api.status.command.has,
							color = { fg = "#ff9e64" },
						},
						-- {
						--     'vim.fn["codeium#GetStatusString"]()',
						--     fmt = function(str)
						--         if str == " ON" then
						--             return " "
						--         elseif str == "OFF" then
						--             return " "
						--         elseif str == " * " then
						--             return " "
						--         else
						--             return str
						--         end
						--     end,
						-- },
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
					lualine_x = {
						{
							"location",
						},
					},
				},
				extensions = { "fugitive", "quickfix", "trouble", "lazy", "mason", recon_lualine_extension },
			})
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl, name = hl })
			end
			--,
			require("nvim-web-devicons").setup({
				default = true,
				override = {},
			})
		end,
	},
	-- {
	--     "anuvyklack/pretty-fold.nvim",
	--     init = function()
	--         require("pretty-fold").setup({
	--             keep_indentation = true,
	--             fill_char = "━",
	--             sections = {
	--                 left = {
	--                     "content",
	--                 },
	--                 right = {
	--                     "┫ ",
	--                     "number_of_folded_lines",
	--                     ": ",
	--                     "percentage",
	--                     " ┣━━━━━━━",
	--                 },
	--             },
	--         })
	--     end,
	-- },
	-- {
	--     "anuvyklack/fold-preview.nvim",
	--     dependencies = "anuvyklack/keymap-amend.nvim",
	--     config = function()
	--         local fp = require("fold-preview")
	--         local keymap = vim.keymap
	--         keymap.amend = require("keymap-amend")
	--
	--         fp.setup({
	--             default_keybindings = false,
	--         })
	--
	--         keymap.amend("n", "K", function(original)
	--             if not fp.toggle_preview() then
	--                 original()
	--             end
	--         end)
	--     end,
	-- },
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
		event = "VeryLazy",
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
		event = "VeryLazy",
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
        event = "VeryLazy",
        keys = {
            { "<leader>n", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
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
								{ find = "%d+L, %d+B" }, -- for file saved
								{ find = "; after #%d+" }, -- for after save state
								{ find = "; before #%d+" }, -- for before save state
								{ find = "%d+ lines yanked" }, -- for yank
								{ find = "W [%d+/%d+]" }, -- for search pattern
								{ find = "fewer lines" },
							},
						},
						view = "mini",
					},
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "is not accessible by the current user!" },
							},
						},
						skip = true,
					},
					{
						filter = {
							event = "notify",
							find = "no information available",
						},
						skip = true,
					},
					{
						filter = {
							event = "notify",
							find = "No information available",
						},
						skip = true,
					},
					{
						filter = { event = "msg_show", min_height = 20 },
						view = "cmdline_output",
					},
				},
			})
		end,
	},
	-- {
	-- 	"h4-mm-3r/recon.nvim",
	-- 	config = function()
	-- 		vim.keymap.set("n", "<leader>ra", function()
	-- 			require("recon.mark").add_file()
	-- 		end, { desc = "Recon Add File" })
	-- 		vim.keymap.set("n", "<leader>rm", function()
	-- 			require("recon.ui").toggle_quick_menu()
	-- 		end, { desc = "Recon Menu" })
	-- 		vim.keymap.set("n", "<C-p>", function()
	-- 			require("recon.ui").nav_prev()
	-- 		end, { desc = "Recon Previous" })
	-- 		vim.keymap.set("n", "<C-n>", function()
	-- 			require("recon.ui").nav_next()
	-- 		end, { desc = "Recon Next" })
	-- 	end,
	-- },
	{
		"recon.nvim",
		dir = "~/git-repos/recon.nvim",
		config = function()
			require("recon").setup()
			vim.keymap.set("n", "<leader>ra", function()
				require("recon.mark").add_file()
			end, { desc = "Recon Add File" })
			vim.keymap.set("n", "<leader>rm", function()
				require("recon.ui").toggle_quick_menu()
			end, { desc = "Recon Menu" })
			vim.keymap.set("n", "<C-p>", function()
				require("recon.ui").nav_prev()
			end, { desc = "Recon Previous" })
			vim.keymap.set("n", "<C-n>", function()
				require("recon.ui").nav_next()
			end, { desc = "Recon Next" })
			vim.keymap.set("n", "<leader>j1", function()
				require("recon.ui").nav_file(1)
			end, { desc = "recon 1" })
			vim.keymap.set("n", "<leader>j2", function()
				require("recon.ui").nav_file(2)
			end, { desc = "recon 2" })
			vim.keymap.set("n", "<leader>j3", function()
				require("recon.ui").nav_file(3)
			end, { desc = "recon 3" })
			vim.keymap.set("n", "<leader>j4", function()
				require("recon.ui").nav_file(4)
			end, { desc = "recon 4" })
		end,
	},
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		opts = function(_, opts)
	-- 			opts.ensure_installed = opts.ensure_installed or {}
	-- 			table.insert(opts.ensure_installed, "http")
	-- 		end,
	-- 	},
	-- },
	{
		"stevearc/dressing.nvim",
	},
}
