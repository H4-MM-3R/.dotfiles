return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local fb_actions = require("telescope").extensions.file_browser.actions

			require("telescope").setup({
				defaults = {
					mappings = {
						n = {
							["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
							["q"] = require("telescope.actions").close,
							["<BS>"] = fb_actions.backspace,
							["<M-/>"] = fb_actions.create,
							["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
						},
						i = {
							["<M-/>"] = fb_actions.create,
							["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
							["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
						},
					},
					prompt_prefix = "   ",
					sorting_strategy = "ascending",
					layout_strategy = "flex",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
						vertical = {
							mirror = false,
							preview_cutoff = 10,
						},
						flex = {
							flip_columns = 100,
						},
						preview_cutoff = 90,
					},
					file_ignore_patterns = {
						"^.git",
						"%.cache",
						"^node_modules/",
						"^build/",
						"^target/",
						"^bin/",
						"^obj/",
					},
				},
				extensions = {
					file_browser = {
						grouped = true,
						hidden = { file_browser = true, folder_browser = true },
						hijack_netrw = true,
						theme = false,
						hide_parent_dir = true,
						follow_symlinks = true,
						display_stat = {
							mode = false,
						},
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
				pickers = {
					find_files = {
						mappings = {
							n = {
								["<C-Q>"] = require("telescope.actions").smart_send_to_qflist,
								["q"] = require("telescope.actions").close,
								["<BS>"] = fb_actions.backspace,
								["<M-/>"] = fb_actions.create,
								["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
							},
							i = {
								["<M-/>"] = fb_actions.create,
								["<C-Q>"] = require("telescope.actions").smart_send_to_qflist,
								["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
							},
						},
					},
					live_grep = {
						layout_config = {
							horizontal = {
								preview_width = 0,
							},
						},
						mappings = {
							n = {
								["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
								["q"] = require("telescope.actions").close,
								["<BS>"] = fb_actions.backspace,
								["<M-/>"] = fb_actions.create,
								["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
							},
							i = {
								["<M-/>"] = fb_actions.create,
								["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
								["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
							},
						},
					},
					current_buffer_fuzzy_find = {
						tiebreak = function(entry1, entry2, prompt)
							local start_pos1 = entry1.ordinal:find(prompt, 1, true) -- plain text search
							if start_pos1 then
								local start_pos2 = entry2.ordinal:find(prompt, 1, true)
								return (start_pos2 and start_pos1 < start_pos2) or false
							end
							return false
						end,
						additional_args = { "--ignore-case", "--pcre2" },
						layout_config = {
							horizontal = {
								preview_width = 0,
							},
						},
						mappings = {
							n = {
								["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
								["q"] = require("telescope.actions").close,
								["<BS>"] = fb_actions.backspace,
								["<M-/>"] = fb_actions.create,
								["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
							},
							i = {
								["<M-/>"] = fb_actions.create,
								["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
								["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
							},
						},
					},
				},
			})
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("recon")
		end,
		keys = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ft", builtin.help_tags, { desc = "Help Tags" })
			-- vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Git Files" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
			vim.keymap.set("n", "<leader>fa", builtin.autocommands, { desc = "AutoCommands" })
			vim.keymap.set("n", "<leader>fo", builtin.vim_options, { desc = "Vim_Options" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
			vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Man Pages" })

			vim.keymap.set("n", "<leader>fs", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Grep String" })
			vim.keymap.set("n", "<leader>fws", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end, { desc = "Grep Word w" })
			vim.keymap.set("n", "<leader>fWs", function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end, { desc = "Grep Word W" })

			-- vim.keymap.set("n", "<leader>en", function()
			-- 	builtin.find_files({
			-- 		cwd = vim.fs.joinpath(vim.fn.stdpath("config")),
			-- 	})
			-- end)
			-- vim.keymap.set("n", "<leader>ep", function()
			-- 	builtin.find_files({
			-- 		cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
			-- 	})
			-- end)
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{

		"folke/trouble.nvim",
		opts = {
			padding = true,
			auto_close = true,
			group = true,
		},
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble<cr>", desc = "Trouble" },
			{ "<leader>xd", "<cmd>Trouble diagnostics<cr>", desc = "Trouble Document Diagnostics" },
			{ "<leader>xq", "<cmd>Trouble quickfix<cr>", desc = "Trouble Quickfix" },
			{ "<leader>xl", "<cmd>Trouble lsp_references<cr>", desc = "Trouble LSP References" },
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
			{
				"<c-k>",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok = pcall(vim.cmd.cnext)
						if not ok then
							pcall(vim.cmd.cfirst)
						end
					end
				end,
				{ desc = "next trouble/ quickfix item" },
			},
			{
				"<c-j>",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok = pcall(vim.cmd.cprev)
						if not ok then
							pcall(vim.cmd.clast)
						end
					end
				end,
				desc = "previous trouble/ quickfix item",
			},
		},
	},
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		opts = {
			arg = "leetcode.nvim",
			lang = "cpp",
			plugins = {
				non_standalone = true,
			},
		},
	},
}
