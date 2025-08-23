return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        picker = require("hemram.plugins.snacks.picker").opts,
        explorer = {
            enabled = true,
            auto_close = true,
            hijack_netrw = true,
        },
        scroll = {
            enabled = false,
        },
        bigfile = {
            enabled = true,
        },
        notifier = {
            enabled = true
        },
        statuscolumn = {
            enabled = true,
            left = { "mark", "sign" },   -- priority of signs on the left (high to low)
            right = { "fold", "git" },   -- priority of signs on the right (high to low)
            folds = {
                open = false,            -- show open fold icons
                git_hl = false,          -- use Git Signs hl for fold icons
            },
            git = {
                -- patterns to match Git signs
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50, -- refresh at most every 50ms
        }
    },
    keys = require("hemram.plugins.snacks.keys"),
}
