local add = require('vim-pack').add

add({
    { src = 'nvim-treesitter/nvim-treesitter' },
    { src = 'nvim-tree/nvim-web-devicons' },
    {
        src = 'nvimdev/lspsaga.nvim',
        opts = {
            symbol_in_winbar = { enable = false },
            rename = {
                keys = {
                    quit = '<Esc>',
                    exec = '<CR>',
                },
            },
            code_action = {
                show_server_name = true,
                keys = {
                    quit = 'q',
                    exec = '<CR>',
                },
            },
            lightbulb = {
                enable = false,
            },
            finder = {
                keys = {
                    toggle_or_open = '<CR>',
                    vsplit = 'vs',
                    split = 's',
                },
            },

        }
    }
})
