return {
	{
		"MoaidHathot/dotnet.nvim",
		cmd = "DotnetUI",
		opts = {
			bootstrap = {
				auto_bootstrap = true,
			},
		},
        config = function()
            require("dotnet").setup({
                enable_diagnostic = true,
                enable_formatting = true,
                enable_task_runner = true,
                enable_test_adapter = true,
            })
        end
	},
    {
        "Hoffs/omnisharp-extended-lsp.nvim"
    },
}
