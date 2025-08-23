return {
	layout = {
        preview = true,
		layout = {
			backdrop = false,
			width = 0.8,
			min_width = 50,
			height = 0.8,
			min_height = 30,
			box = "vertical",
			border = "rounded",
			title_pos = "center",
			{ win = "preview", height = 0.2},
			{ win = "input", height = 1, border = "rounded", title = "Grep {live} {flags}" },
			{ win = "list", border = "none" },
		},
	},
}
