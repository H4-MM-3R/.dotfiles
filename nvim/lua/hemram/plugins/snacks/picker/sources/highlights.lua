return {
	layout = {
		preview = true,
		layout = {
			backdrop = false,
			width = 0.2,
            max_width = 50,
            position = "right",
			border = "none",
			box = "vertical",
			{
				win = "input",
				height = 1,
				border = "rounded",
				title = "{title} {live} {flags}",
				title_pos = "center",
			},
			{ win = "list", border = "none" },
			{ win = "preview", border = "rounded", height = 0.4 },
		},
	},
}
