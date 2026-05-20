local add = require('vim-pack').add

add({
    -- Dependencies
    { src = 'MunifTanjim/nui.nvim', setup = false },
    {
        src = 'rcarriga/nvim-notify',
        module_name = 'notify',
        opts = {
            render = 'default',
            stages = 'fade',
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.50)
            end,
        },
        on_setup = function()
            local notify = require('notify')
            vim.notify = notify.notify
        end
    },

    {
        src = 'folke/noice.nvim',
        opts = {
            messages = {
                -- NOTE: If you enable messages, then the cmdline is enabled automatically.
                -- This is a current Neovim limitation.
                enabled = true, -- enables the Noice messages UI
                view = "notify", -- default view for messages
                view_error = "notify", -- view for errors
                view_warn = "notify", -- view for warnings
                view_history = "popup", -- view for :messages
                view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
            },
        },
        on_setup = function()
            vim.keymap.set('n', '<leader>sm', '<CMD>messages<CR>', { desc = 'View messages history' })
        end
    },
})
