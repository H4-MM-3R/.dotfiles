require('pretty-fold').setup{
    keep_indentation = true,
    fill_char = '━',
    sections = {
        left = {
            'content'
        },
        right = {
            '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━━━━━━',
        }
    }
}

-- Preview
local fp = require('fold-preview')
local keymap = vim.keymap
keymap.amend = require('keymap-amend')

fp.setup({
 default_keybindings = false
})

keymap.amend('n', 'K', function(original)
 if not fp.toggle_preview() then original() end
end)
