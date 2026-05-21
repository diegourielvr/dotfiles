-- settings: https://luals.github.io/wiki/settings/

local root_markers1 = {
    '.emmyrc.json',
    '.luarc.json',
    '.luarc.jsonc',
}
local root_markers2 = {
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
}

---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers1, root_markers2, { '.git' } }
        or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { '.git' }),
    ---@type lspconfig.settings.lua_ls
    settings = {
        Lua = {
            codeLens = { enable = true },

            completion = {
                autoRequire = true,
                callSnippet = "Replace", -- "Disable", "Both", "Replace"
            },
            -- Fix Undefined global 'vim'
            diagnostics = {
                globals = { "vim" }, -- Variables declaradas como globales
            },
            hint = {
                enable = true,
                semicolon = "Disable",
                paramName = "All",
                paramType = true,
                arrayIndex = "Disable",
            },
            telemetry = {
                enable = false,
            },
            window = {      -- https://luals.github.io/wiki/settings/#window
                progressBar = true, -- NOTE: Show a progress bar in the bottom status bar that shows how the workspace loading is progressing.
            },
        },
    },
}
