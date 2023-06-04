local wk = require("which-key")

wk.register({
  f = {
    name = "find",
    c = { "find in current buffer" },
    f = { "find files"},
    b = { "find buffers"},
    l = { "find in live-grep"},
    h = { "find help-tags"},
    g = { "find git "},
  },
}, { prefix = "<Leader>" })
