local add_on_event = require('vim-pack').add_on_event
local vbar_icon = require('icons').misc.vertical_bar

add_on_event({ 'BufReadPre', 'BufNewFile'}, {
    {
        src = 'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add          = { text = vbar_icon },
                change       = { text = vbar_icon },
                delete       = { text = vbar_icon },
                topdelete    = { text = vbar_icon },
                changedelete = { text = vbar_icon },
                untracked    = { text = vbar_icon },
            },
            signs_staged = {
                add          = { text = vbar_icon },
                change       = { text = vbar_icon },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            update_debounce = 100, -- Debounce time for updates (in milliseconds).
            max_file_length = 10000, -- Disable if file is longer than this (in lines)
            preview_config = { border = 'rounded' },
        },
    }
})

