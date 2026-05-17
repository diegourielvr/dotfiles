local add = require('vim-pack').add
local vbar_icon = require('icons').misc.vertical_bar

add({
    {
        src = 'lukas-reineke/indent-blankline.nvim',
        module_name = 'ibl',
        opts = {
            indent = {
                char = '│',
                tab_char = '│',
            },
            scope = {
                enabled = false,
            },
        },
    }
})
