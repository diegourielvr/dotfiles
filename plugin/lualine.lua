local add = require('vim-pack').add
local git_icons = require('icons').git

add {
    -- Dependencies
    { src = 'nvim-tree/nvim-web-devicons' },

    {
        src = 'nvim-lualine/lualine.nvim',
        setup = false,
        on_setup = function()
            local MODES = {
                ['i'] = { 'INSERT', "#81ffc6" }, -- INSERT
                ['n'] = { 'NORMAL' }, -- NORMAL
                ['v'] = { 'VISUAL', "#ffcc00" }, -- VISUAL
                ['R'] = { 'Replace', "#FF8989" },
                ['c'] = { 'command-line' },
                ['ce'] = { 'NORMAL EX' },
                ['cv'] = { 'EX' },
                ['ic'] = { 'INS-COMPLETE' },
                ['no'] = { 'OPERATOR-PENDING' }, -- d, y, c
                ['r'] = { 'HIT-ENTER', },
                ['r?'] = { ':CONFIRM' },
                ['rm'] = { '--MORE' },
                ['Rv'] = { 'VIRTUAL' }, -- gR virtual
                ['s'] = { 'SELECT' }, --gh select
                ['S'] = { 'SELECT LINE' }, --gH
                ['␓'] = { 'SELECT BLOCK' },
                ['t'] = { 'TERMINAL' },
                ['V'] = { 'VISUAL LINE' },
                ['␖'] = { 'VISUAL BLOCK' },
                ['!'] = { 'SHELL' },
            }

            local modes = {
                function()
                    return vim.g.libmodalActiveModeName or MODES[vim.api.nvim_get_mode().mode][1]
                end,
                -- icon = { "", align = "left" },
                separator = { left = "", right = "" },
                color = { bg = "NONE" },
                -- color = function()
                -- 	-- return { bg = "NONE", fg = "#f5f5f5" }
                -- 	return { bg = MODES[vim.g.libmodalActiveModeName] or MODES[vim.api.nvim_get_mode().mode][2], fg = "#252525" }
                -- end,
            }

            local branch = {
                "branch",
                icon = git_icons.branch, -- '' | '󰊢'
                color = { bg = "NONE" },
                padding = 1, -- espacio a los lados
            }

            local diff = {
                "diff",
                colored = true,
                symbols = {
                    added = git_icons.added,
                    modified = git_icons.modified,
                    removed = git_icons.removed,
                },
                color = { bg = "NONE" },
            }

            local filename = {
                "filename",
                file_status = false, -- mostrar estado del archivo
                path = 1,   -- 0: just filename, 1: relative path, 2: absolute path, 3
                color = { bg = "NONE" },
            }

            local search = {
                'searchcount',
                icon = { "", align = "left" },
                color = { bg = "NONE" },
            }

            local diagnostics = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = {
                    "error",
                    "warn",
                    "hint",
                    "info"
                },
                symbols = {
                    error = " ",
                    warn  = " ",
                    hint  = "󰌶 ",
                    info  = " ",
                },
                colored = true,
                always_visible = false,
                update_in_insert = false, -- Update diagnostics in insert mode.
                color = { bg = "NONE" }
            }

            local lsp = {
                "lsp_status",
                color = { bg = "NONE" }
            }

            local encoding = {
                "encoding",
                icon = { "", align = "left" },
                color = { bg = "NONE" }
            }

            local indent = {
                function()
                    return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
                end,
                icon = { "󱇂", align = "left" },
                color = { bg = "NONE" }
            }

            local progress = {
                "progress",
                icon = { "", align = "left" },
                color = { bg = "NONE" },
            }

            local location = function()
                local line = vim.fn.line '.'
                local line_count = vim.api.nvim_buf_line_count(0)
                local col = vim.fn.virtcol '.'

                return table.concat {
                    string.format(' %d/%d ', line, line_count),
                    string.format(' %d', col)
                }
            end

            local custom_theme = {
                normal = {
                    a = { bg = "None" },
                    b = { bg = "None" },
                    c = { bg = "None" },
                },
            }

            local opts = {
                options = {
                    theme = "auto", -- 'auto'
                    icons_enabled = true,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        "dashboard", "nvim-tree", "alpha"
                    },
                    always_divide_middle = true,
                    globalstatus = true, -- una sola linea de estado
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            }

            opts.options.theme = custom_theme

            opts.sections = {
                lualine_a = { modes, },
                lualine_b = { branch, diff, },
                lualine_c = { },
                lualine_x = { search, location, progress, },
                lualine_y = { diagnostics, lsp, },
                lualine_z = { indent, encoding, },
            }

            require('lualine').setup(opts)
        end
    }
}
