local add = require('vim-pack').add
local on_plugin_update = require('vim-pack').on_plugin_update

add({
    -- Dependencies
    { src = 'saghen/blink.lib', setup = false },
    { src = 'rafamadriz/friendly-snippets', setup = false },

    {
        src = 'L3MON4D3/LuaSnip',
        module_name = 'luasnip',
        on_setup = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },

    {
        src = 'saghen/blink.cmp',
        opts = {
            cmdline = {
                enabled = true,
                completion = {
                    list = {
                        selection = { preselect = true, auto_insert = false }
                    },
                    ghost_text = { enabled = true },
                },
                keymap = {
                    ['<CR>'] = { 'accept', 'fallback' },
                    ['<C-\\>'] = { 'hide', 'fallback' },
                    ['<C-n>'] = { 'select_next', 'show' },
                    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                    ['<C-p>'] = { 'select_prev' },
                },
            },
            snippets = { preset = 'luasnip' },
            completion = {
                list = {
                    selection = { preselect = true, auto_insert = false },
                    max_items = 15,
                },
                menu = {
                    scrollbar = true,
                    draw = {
                        gap = 2,
                        columns = {
                            { 'kind_icon', 'kind', gap = 1 },
                            { 'label', 'label_description', gap = 1 },
                        },
                    },
                },
                documentation = { auto_show = true },
                ghost_text = { enabled = true },
            },
            keymap = {
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-\\>'] = { 'hide', 'fallback' },
                ['<C-n>'] = { 'select_next', 'show' },
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<C-p>'] = { 'select_prev' },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            },
            -- signature = { enabled = true },
            sources = {
                -- Disable some sources in comments and strings.
                default = function()
                    local sources = { 'lsp', 'buffer' }
                    local ok, node = pcall(vim.treesitter.get_node)

                    if ok and node then
                        if not vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                            table.insert(sources, 'path')
                        end
                        if node:type() ~= 'string' then
                            table.insert(sources, 'snippets')
                        end
                    end
                    

                    return sources
                end,
            },
            -- appearance = {
            --     kind_icons = require('icons').symbol_kinds,
            -- },
        },
    }
})

on_plugin_update('blink.cmp', function()
    require('blink.cmp').build():wait(60000)
end)
