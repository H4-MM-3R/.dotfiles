return {
	{
		"lewis6991/gitsigns.nvim",
		enabled = true,

		config = function()
			require("gitsigns").setup()
		end,
	},
	-- {
	--     "echasnovski/mini.diff",
	--     event = "VeryLazy",
	--     keys = {
	--         {
	--             "<leader>go",
	--             function()
	--                 require("mini.diff").toggle_overlay(0)
	--             end,
	--             desc = "Toggle mini.diff overlay",
	--         },
	--     },
	--     opts = {
	--         view = {
	--             style = "sign",
	--             signs = {
	--                 add = "▎",
	--                 change = "▎",
	--                 delete = "",
	--             },
	--         },
	--     },
	-- },
}
