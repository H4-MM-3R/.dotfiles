local data_path = vim.fn.stdpath("cache") .. "/jdtls/workspace"
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/config"
local bundles_path = {
	vim.fn.glob(
		vim.env.HOME .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"
	),
}

local config = {

	    cmd = {
	        'jdtls',
	        "configuration",
	        workspace_dir,
	        "-data",
	        data_path,
	},

	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
	init_options = {
		bundles = bundles_path,
	},
	on_attach = function()
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end,
	settings = {
		java = {
			-- format = {
			--     enabled = true,
			--     settings = {
			--         profile = "google_format",
			--     },
			-- },
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
				parameterTypes = {
				    enabled = true,
				},
				variableTypes = {
				    enabled = true,
				},
			},
		},
	},
}
require("jdtls").start_or_attach(config)
