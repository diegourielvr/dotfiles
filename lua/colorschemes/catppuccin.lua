local add = require('vim-pack').add

add {
    {
        src = 'catppuccin/nvim',
        module_name = 'catppuccin',
        -- setup = false,
        opts = {
            -- asdasdasdasd a asd asd ada 
            styles = {
                comments = { 'italic' },
                strings = { 'italic' },
            },
        },
        on_setup = function()
            vim.cmd.colorscheme 'catppuccin-nvim'
        end
    }
}
