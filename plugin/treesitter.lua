-- :checkhealth nvim-treesitter
local add = require('vim-pack').add
local on_plugin_update = require('vim-pack').on_plugin_update

local parsers = {
    'bash',
    'c',
    'cpp',
    'gitcommit',
    'html',
    'java',
    'javascript',
    'json',
    'json5',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'regex',
    'rust',
    'sql',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
}

add {
    {
        src = 'nvim-treesitter/nvim-treesitter',
        opts = {},
        on_setup = function()
            local init = vim.api.nvim_get_runtime_file('lua/nvim-treesitter/init.lua', false)[1]
            if init then
                vim.opt.runtimepath:prepend(vim.fn.fnamemodify(init, ':h:h:h') .. '/runtime')
            end

            require('nvim-treesitter').install(parsers):wait(300000)
        end
    }
}

on_plugin_update('nvim-treesitter', function()
    -- Re-install (picks up any newly-added parsers from the list above)
    -- and update existing ones.
    require('nvim-treesitter').install(parsers):wait(300000)
    require('nvim-treesitter').update():wait(300000)
end)

vim.keymap.set('n', '<leader>ts', ' <CMD>InspectTree<CR>', { desc = 'Inspect Tree'})


