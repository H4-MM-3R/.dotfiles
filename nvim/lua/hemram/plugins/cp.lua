return {
	{
		"xeluxee/competitest.nvim",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("competitest").setup({
				runner_ui = {
					interface = "split",
				},
				template_file = {
					cpp = "/home/hemram/.config/nvim/template.cpp",
				},
				evaluate_template_modifiers = true,
				testcases_input_file_format = "$(FNOEXT)$(TCNUM).in",
				testcases_output_file_format = "$(FNOEXT)$(TCNUM).ans",
				compile_command = {
					cpp = {
						exec = "clang++",
						args = {
							"-static",
							"-s",
							"-lm",
							"-DLOCAL",
							"-Wall",
							"-Wextra",
							"-O2",
							"-std=c++17",
							"$(FNAME)",
							"-o",
							"$(FNOEXT)",
						},
					},
				},
                run_command = {
                    exec = "timeout 1s ./$(FNOEXT)",
                },
			})
		end,
	},
}
