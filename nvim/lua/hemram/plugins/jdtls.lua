return {
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	-- {
	-- 	"nvim-java/nvim-java",
	-- 	config = function()
	-- 		require("java").setup()
	-- 		require("lspconfig").jdtls.setup({})
	-- 	end,
	-- },
	{
		"rcasia/neotest-java",
		ft = "java",
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-java")(),
				},
			})
		end,
	},
}
