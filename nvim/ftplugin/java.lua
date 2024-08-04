local jdtls = require("jdtls")
local lombok_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
local config_path = vim.fn.stdpath("cache") .. "jdtls/config"
local data_path = vim.fn.stdpath("cache") .. "jdtls/workspace"
local bundles_path = {
    vim.fn.glob(vim.env.HOME .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar')
}
local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local config = {
    cmd = {
        "jdtls",
        "--jvm-arg=-javaagent:" .. lombok_path,
        "-config",
        config_path,
        "-data",
        data_path,
    },
    handlers = handlers,
    init_options = {
        bundles = bundles_path,
    },
}

config['on-attach'] = function(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
end
require("jdtls").start_or_attach(config)
