return {
	"craftzdog/solarized-osaka.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("solarized-osaka").setup({
			transparent = false,
			terminal_colors = true,
            lualine_bold = true,
            dim_inactive = true,
            sidebars = { "qf", "terminal", "Outline", "help"},
            on_highlights = function(hl)
                hl.TelescopeBorder = { fg = "none", bg = "none" }
                hl.TelescopeSelection = { fg = "none", bg = "#002c38", reverse = false }
                hl.TroubleNormal = { fg = "none", bg = "none" }
                hl.TroubleCount = { fg = "none", bg = "none" }
                hl.TodoBgFIX = { fg = "#001419", bg = "#db2038" }
                hl.TodoBgTODO = { fg = "#001419", bg = "#268bd3" }
                hl.TodoBgNOTE = { fg = "#001419", bg = "#29a298" }
                hl.QuickFixLine = { fg = "none", bg = "#002c38" }
            end
		})
		vim.cmd([[colorscheme solarized-osaka]])
	end,
}
