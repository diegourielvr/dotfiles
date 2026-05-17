local add = require('vim-pack').add

add {
    { src = 'nvim-lua/plenary.nvim' },
    {
        src = 'nvim-telescope/telescope-file-browser.nvim',
        setup = false,
    },
    {
        src = 'nvim-telescope/telescope.nvim',
        version = '*',
        opts = {
            defaults = {
                prompt_prefix = "   ",
                selection_caret = " ",
                entry_prefix = "  ",
                multi_icon = " ",
                initial_mode = "normal", -- 'insert' | 'normal'
                border = true,
            },
            extensions = {
                file_browser = {
                    hidden = { file_browser = true, folder_browser = true },
                    git_status = true,
                    display_stat = { mode = false, size = false, date = false },
                },
            },
        },
        on_setup = function()
            require('telescope').load_extension('file_browser')
        end,
    }
}

vim.keymap.set('n', '<leader>e', ':Telescope file_browser path=%:p:h select_buffer=true<CR><C-h>', { desc = 'Open file browser' })
vim.keymap.set('n', '<leader>of', '<CMD>Telescope oldfiles<CR>', { desc = 'Old files' })

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })

