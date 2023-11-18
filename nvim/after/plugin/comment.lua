require("Comment").setup {
    opleader = {
        line = "gc",
        block = "gb",
    },
    mappings = {
        basic = true,
        extra = true,
    },
    toggler = {
        line = "gcc",
        block = "gbc",
    },
}
local comment_ft = require "Comment.ft"
comment_ft.set("lua", { "--%s", "--[[%s]]" })
