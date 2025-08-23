local M = {}

M.opts = {
	enabled = true,
	sources = {
		explorer = require("hemram.plugins.snacks.picker.sources.explorer"),
		files = require("hemram.plugins.snacks.picker.sources.files"),
		lines = require("hemram.plugins.snacks.picker.sources.lines"),
		grep = require("hemram.plugins.snacks.picker.sources.grep"),
		highlights = require("hemram.plugins.snacks.picker.sources.highlights"),
        lsp_symbols = require("hemram.plugins.snacks.picker.sources.lsp_symbols"),
	},
	win = {
		input = {
			keys = {
				["<c-r>"] = {
					"reconlist",
					mode = { "n" },
				},
			},
		},
		list = {
			keys = {
				["<c-r>"] = {
					"reconlist",
					mode = { "n" },
				},
			},
		},
	},
	actions = {
		reconlist = function(picker)
			local function setreconlist(items)
				vim.tbl_map(function(entry)
					pcall(require("recon.mark").add_file, entry.file)
					vim.print(entry.file)
				end, items)
			end

			picker:close()
			local sel = picker:selected()
			local items = #sel > 0 and sel or picker:items()
			setreconlist(items)
			pcall(require("recon.ui").toggle_quick_menu)
		end,
	},
}

return M
