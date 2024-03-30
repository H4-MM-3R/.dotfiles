local lombok_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
local config_path = vim.fn.stdpath("cache") .. "jdtls/config"
local data_path = vim.fn.stdpath("cache") .. "jdtls/workspace"

local config = {
	cmd = {
		"jdtls",
		'--jvm-arg=-javaagent:' .. lombok_path,
       '-config', config_path,
        '-data', data_path,
	},
}
require("jdtls").start_or_attach(config)

