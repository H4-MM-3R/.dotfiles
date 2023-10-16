local wk = require("which-key")

-------------------------------------------------

wk.register({
    f = {
        name = "Find",
        f = { "Find files"},
        l = { "Find in live-grep"},
        b = {
            name = "Telescope Menu",
            f = "Find Buffers"
        },
        h = { "Find help-tags"},
        g = { "Find git "},
        c = { "Find in current buffer" },
        k = { "Find Keymaps" },
    },
}, { prefix = "<Leader>" })

-------------------------------------------------

wk.register({
    g = {
        name = "Game",
        g = { "Game_of_Life" },
        r = { "Make_it_Rain" },
        v = { "Vim_Be_Good" },
        t = { "Tetris" },
    },
}, { prefix = "<Leader>" })

-------------------------------------------------

wk.register({
    h = {
        name = "Harpoon",
        a = { "add file" },
        m = { "harpoon menu "},
    },
}, { prefix = "<Leader>" })

-------------------------------------------------

wk.register({
    y = "Copy file to ClipBoard",
},{prefix = "<Leader>"})

-------------------------------------------------

wk.register({
    z = "Zen Mode",
},{ prefix = "<Leader>",})

-------------------------------------------------

wk.register({
    c = {
        name = "Code",
        a = { "Action" },
    },
}, { prefix = "<Leader>" })

-------------------------------------------------

wk.register({
    b = "File Browser",
}, { prefix = "<Leader>"})

