local add = require('vim-pack').add

-- Descargar los servidores LSP necesarios con Mason
add({
    {
        src = 'mason-org/mason.nvim',
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "",
                    package_uninstalled = "✗"
                }
            }
        },
        on_setup = function()
            vim.keymap.set('n', '<leader>M', '<CMD>Mason<CR>', { desc = 'Open Mason' })
        end
    },
    -- {
    --     src = 'neovim/nvim-lspconfig',
    --     setup = false,
    -- },
})
