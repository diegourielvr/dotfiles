local add_on_event = require('vim-pack').add_on_event
local vbar_icon = require('icons').misc.vertical_bar

add_on_event('BufEnter', {
    {
        src = 'echasnovski/mini.indentscope',
        version = 'stable',
        opts = {
            symbol = '│', -- "▏"
            options = {
                try_as_border = true
            },
        },
    }
})
