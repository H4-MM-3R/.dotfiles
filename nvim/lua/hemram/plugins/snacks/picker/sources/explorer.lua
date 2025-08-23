return {
	layout = {
		preview = true,
		layout = {
			box = "horizontal",
			width = 0.8,
			zindex = 10,
			min_width = 120,
			height = 0.85,
			{
				box = "vertical",
				border = "rounded",
				title = "{title}",
				{ win = "input", height = 1, border = "bottom" },
				{ win = "list", border = "none" },
			},
			{
				win = "preview",
				title = "{preview}",
				border = "rounded",
				width = 0.7,
			},
		},
	},
	auto_close = true,
}
