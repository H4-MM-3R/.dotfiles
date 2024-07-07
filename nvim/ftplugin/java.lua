local lombok_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
local config_path = vim.fn.stdpath("cache") .. "jdtls/config"
local data_path = vim.fn.stdpath("cache") .. "jdtls/workspace"
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
}
require("jdtls").start_or_attach(config)
