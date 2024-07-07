return {
	{
		"nvim-telescope/telescope.nvim",
		init = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						n = {
							["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
							["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
							["<C-h>"] = require("customs.telescope_harpoon_action").mark_file,
						},
						i = {
							["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
							["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
							["<C-h>"] = require("customs.telescope_harpoon_action").mark_file,
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
				},
				extensions = {
					file_browser = {
						grouped = true,
						hidden = { file_browser = true, folder_browser = true },
						hijack_netrw = true,
						theme = false,
						hide_parent_dir = true,
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("fzf")
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
		keys = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fl", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fs", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
			vim.keymap.set("n", "<leader>fws", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end)
			vim.keymap.set("n", "<leader>fWs", function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end)
			vim.keymap.set("n", "<leader>ft", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
			vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>fb", builtin.builtin, {})
			vim.keymap.set("n", "<leader>fa", builtin.autocommands, { desc = "AutoCommands" })
			vim.keymap.set("n", "<leader>fo", builtin.vim_options, { desc = "Vim_Options" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
			vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Man Pages" })
		end,
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
				"<c-j>",
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
				"<c-k>",
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
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				TODO = { icon = " " },
				NOTE = { icon = "󱞁 " },
				TEST = { icon = " " },
			},
			search = {
				command = "rg",
				args = {
					"--glob=!node_modules/",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
			},
		},
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"kawre/leetcode.nvim",
		opts = {
			lang = "java",
		},
		init = function()
			if vim.v.argv[3] == "leetcode.nvim" then
				vim.keymap.set("n", "<leader>dl", ":silent Leet list<CR>", { desc = "LeetCode List" })
				vim.keymap.set("n", "<leader>dt", ":silent Leet test<CR>", { desc = "LeetCode Test" })
				vim.keymap.set("n", "<leader>dd", ":silent Leet submit<CR>", { desc = "LeetCode Submit" })
				vim.keymap.set("n", "<leader>dc", ":silent Leet console<CR>", { desc = "LeetCode Console" })
				vim.keymap.set("n", "<leader>di", ":silent Leet info<CR>", { desc = "LeetCode Information" })
			end
		end,
	},
}
