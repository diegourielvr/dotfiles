local add_on_event = require('vim-pack').add_on_event
local diagnostic_icons = require('icons').diagnostics
local git_icons = require('icons').git

add_on_event({ 'BufReadPre', 'BufNewFile'}, {
    -- Dependencies
    { src = 'nvim-tree/nvim-web-devicons' },

    {
        src = 'romgrk/barbar.nvim',
        opts = {
            icons = {
                button = '',
                diagnostics = { -- Enables / disables diagnostic symbols
                    [vim.diagnostic.severity.ERROR] = { enabled = false, icon = diagnostic_icons.ERROR },
                    [vim.diagnostic.severity.WARN] = { enabled = false, icon = diagnostic_icons.WARN },
                    [vim.diagnostic.severity.INFO] = { enabled = false, icon = diagnostic_icons.INFO },
                    [vim.diagnostic.severity.HINT] = { enabled = false, icon = diagnostic_icons.HINT },
                },
                gitsigns = {
                    added = { enabled = false, icon = git_icons.added },
                    changed = { enabled = false, icon = git_icons.modified },
                    deleted = { enabled = false, icon = git_icons.removed },
                },
                separator = { left = '┃', right = '' },
                separator_at_end = false, -- If true, add an additional separator at the end of the buffer list
                modified = { button = '󰧞 ' }, -- Configure the icons on the bufferline when modified or pinned.

                -- Configure the icons on the bufferline based on the visibility of a buffer.
                -- Supports all the base icon options, plus `modified` and `pinned`.
                alternate = { filetype = { enabled = false } },
                current = { buffer_index = false },
                inactive = { button = '×' },
                visible = { modified = { buffer_number = false } },
            },
            insert_at_end = true, -- If true, new buffers will be inserted at the start/end of the list.
        },



    }
})
