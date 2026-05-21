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

            vim.keymap.set('n', '<leader>ts', ' <CMD>InspectTree<CR>', { desc = 'Inspect Tree'})

            vim.api.nvim_create_autocmd('FileType', {
                pattern = { '*' },
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    local lang = vim.treesitter.language.get_lang(ft)
                    if not vim.treesitter.language.add(lang) then
                        local available = vim.g.ts_available or require('nvim-treesitter').get_available()
                        if not vim.g.ts_available then
                            vim.g.ts_available = available
                        end
                        if vim.tbl_contains(available, lang) then
                            require('nvim-treesitter').install(lang)
                        end
                    end
                    if vim.treesitter.language.add(lang) then
                        vim.treesitter.start(args.buf, lang)
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end
    }
}

on_plugin_update('nvim-treesitter', function()
    -- Re-install (picks up any newly-added parsers from the list above)
    -- and update existing ones.
    require('nvim-treesitter').install(parsers):wait(300000)
    require('nvim-treesitter').update():wait(300000)
end)


-- Activar el resaltado nativo de Treesitter según el tipo de archivo
-- vim.api.nvim_create_autocmd('FileType', {
--     callback = function(args)
--         -- Si el parser del lenguaje está instalado, activa el resaltado nativo
--         local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) or vim.bo[args.buf].filetype
--         local has_parser = pcall(vim.treesitter.query.get, lang, 'highlights')
--
--         if has_parser then
--             vim.treesitter.start(args.buf, lang)
--         end
--     end,
-- })
--
