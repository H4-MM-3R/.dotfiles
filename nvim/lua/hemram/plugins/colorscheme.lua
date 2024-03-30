return {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        transparent = false,
        terminal_colors = true,

    },
    init =  function()
        vim.cmd([[colorscheme solarized-osaka]])
        vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none", fg = "none"})
        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#002c38", reverse = false })
        vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "none", fg = "none" })
        vim.api.nvim_set_hl(0, "TroubleCount", { bg = "none", fg = "none" })
        vim.api.nvim_set_hl(0, "TodoBgFIX", { fg = "#001419", bg = "#db2038" })
        vim.api.nvim_set_hl(0, "TodoBgTODO", { fg = "#001419", bg = "#268bd3" })
        vim.api.nvim_set_hl(0, "TodoBgNOTE", { fg = "#001419", bg = "#29a298" })
        vim.api.nvim_set_hl(0, "QuickFixLine", { bg = "#002c38" })
    end,
}

