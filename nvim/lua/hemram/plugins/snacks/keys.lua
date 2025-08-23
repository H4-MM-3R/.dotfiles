return {
	{
		"<leader>sn",
		function()
			Snacks.picker.pickers()
		end,
		desc = "Snacks",
	},
	{
		"<leader>b",
		function()
			Snacks.picker.explorer()
		end,
	},
	{
		"<leader>ls",
		function()
			Snacks.picker.lsp_symbols({
				layout = {
					preset = "sidebar",
					layout = {
						position = "right",
					},
				},
			})
		end,
	},
	{
		"<leader>ff",
		function()
			Snacks.picker.files()
		end,
	},
	{
		"<leader>fc",
		function()
			Snacks.picker.lines()
		end,
	},
	{
		"<leader>fl",
		function()
			Snacks.picker.grep()
		end,
	},
	{
		"<leader>fh",
		function()
			Snacks.picker.highlights()
		end,
	},
}
