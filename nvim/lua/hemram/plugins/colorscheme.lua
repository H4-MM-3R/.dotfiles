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
                hl.ReconPrefix = { bg="#073642" , fg="#001419"}
                hl.ReconActive = { bg="none" , fg="#eee8d5"}
                hl.ReconNumberActive = { bg="#073642" , fg="#eee8d5"}
                hl.ReconNumberActiveAnti = { bg="none" , fg="#073642"}
                hl.ReconInactive = { bg="none" , fg="#586e75"}
                hl.ReconNumberInactive = { bg="#073642" , fg="#586e75"}
                hl.ReconNumberInactiveAnti = { bg="none" , fg="#073642"}
                hl.ReconTabline = { bg="#001419" , fg="#073642"}
                hl.ReconTablineAnti = { bg="#073642" , fg="#adb8b8"}
                hl.TabLineFill = { bg="#001419"}
            end
		})
		vim.cmd([[colorscheme solarized-osaka]])
	end,
}
