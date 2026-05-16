local add_on_event = require('vim-pack').add_on_event

add_on_event('InsertEnter', {
    {
        src = 'windwp/nvim-autopairs',
        opts = {},
    }
})
