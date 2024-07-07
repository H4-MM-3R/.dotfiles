return {
	{
		"nvim-treesitter/nvim-treesitter",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				highlight = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,

						keymaps = {
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["if"] = "@function.inner",
							["af"] = "@function.outer",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of class region" },
						},
						selection_modes = {
							["@parameter.outer"] = "V", -- charwise
							["@function.outer"] = "V", -- linewise
							["@block.outer"] = "V", -- linewise
							["@class.outer"] = "V", -- blockwise
						},
					},
				},
			})
			vim.filetype.add({
				extension = {
					mdx = "mdx",
				},
			})
			vim.treesitter.language.register("markdown", "mdx")
		end,
	},
}
