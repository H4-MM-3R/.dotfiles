return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		-- add any opts here
		provider = "copilot",
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		{
			"zbirenbaum/copilot.lua",
            config = function()
                require("copilot").setup()
            end,
		}, -- for providers='copilot'
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
				latex = {
					enabled = false,
				},
				win_options = { conceallevel = { rendered = 2 } },
			},
			ft = { "markdown", "Avante" },
		},
		{
			"jbyuki/nabla.nvim",
			event = "VeryLazy",
			config = function()
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = {"markdown", "latex", "tex" },
                    callback = function()
                        require("nabla").enable_virt({ autogen = true, silent = true })
                    end
                })
			end,
		},
	},
}
