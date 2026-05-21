local function on_attach(client, bufnr)
    local function keymap(lhs, rhs, opts, mode)
        mode = mode or 'n'
        opts = type(opts) == 'string' and { desc = opts } or opts
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    keymap('K', '<CMD>Lspsaga hover_doc<CR>', 'vim.lsp.buf.hover')
    keymap('gF', vim.lsp.buf.format, 'Format a buffer')
    keymap('gF', vim.lsp.buf.format, 'Format lines', 'v')
    keymap('grn', '<CMD>Lspsaga rename<CR>', 'vim.lsp.buf.rename')

    if client:supports_method 'textDocument/codeAction' then
        keymap('<leader>ca', '<CMD>Lspsaga code_action<CR>', 'vim.lsp.buf.code_action')
    end


    if client:supports_method 'textDocument/documentcolor' then
        keymap('grc', function()
            vim.lsp.document_color.color_presentation()
        end, 'vim.lsp.document_color.color_presentation()', { 'n', 'x' })
    end

    -- keymap('<leader>dh', vim.lsp.buf.document_highlight, 'vim.lsp.buf.document_highlight')
    -- keymap('<leader>cr', vim.lsp.buf.clear_references, 'vim.lsp.buf.clear_references')

    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    if client:supports_method 'textDocument/references' then
        keymap('grr', '<CMD>Lspsaga finder def+imp+ref<CR>', 'vim.lsp.buf.references')
    end


    if client:supports_method 'textDocument/typeDefinition' then
        keymap('gy', '<CMD>Lspsaga goto_type_definition<CR>', 'Go to type definition')
    end

    if client:supports_method 'textDocument/documentSymbol' then
        keymap('<leader>fs', '<CMD>Lspsaga outline<CR>', 'vim.lsp.buf.document_symbol')
    end

    if client:supports_method 'textDocument/definition' then
        keymap('gd', '<CMD>:Lspsaga goto_definition<CR>', 'vim.lsp.buf.definition')
        keymap('gD', '<CMD<Lspsaga peek_definition<CR>', 'Peek definition')
    end

    if client:supports_method 'textDocument/signatureHelp' then
        keymap('<C-k>', function()
            -- Close the completion menu first (if open).
            if require('blink.cmp.completion.windows.menu').win:is_open() then
                require('blink.cmp').hide()
            end

            vim.lsp.buf.signature_help()
        end, 'Signature help', 'i')
    end

    if client:supports_method 'textDocument/inlayHint' then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr = bufnr })
    end

    keymap('<leader>sbd', '<cmd>Lspsaga show_buf_diagnostics<CR>', 'Show buffer diagnostics')
    keymap('<leader>sld', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Show line diagnostics')
    keymap('<leader>scd', '<cmd>Lspsaga show_cursor_diagnostics<CR>', 'show cursor diagnostics')
    keymap('<leader>swd', '<cmd>Lspsaga show_workspace_diagnostics<CR>', 'vim.lsp.buf.workspace_diagnostics')
    keymap(']D', '<CMD>Lspsaga diagnostic_jump_next<CR>', 'Jump next diagnostic')
    keymap('[D', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Jump prev diagnostic')
end

vim.diagnostic.config({
    underline = true,
    virtual_text = {
        spacing = 2,
        source = 'if_many',
        prefix = ''
    },
    float = {
        -- header = 'Description:', -- cabecera del diagnostico
        source = false, -- mostrar la fuente del diagnostico
        title = '󱉶 Diagnostic', -- titulo de la ventana flotante
        title_pos = 'center', -- posición de la ventana flotante
        border = 'rounded', -- estilo de borde
        focusable = true, -- ventana flotante focusable
    },
    update_in_insert = true, -- Actualizar diagnosticos en modo insertar, de lo contrario, actualizar al salir del modo insertar
    severity_sort = true, -- Mostrar diagnosticos por grado de severidad
    signs = { -- https://neovim.io/doc/user/diagnostic.html#diagnostic-signs
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '󰌶',
        }
    }
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})

-- Set up LSP servers.
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        -- Extend neovim's client capabilities with the completion ones.
        vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })

        local servers = vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ':t:r')
            end)
            -- Filtra y elimina GITLAB DUO:
            :filter(function(server_name)
                return server_name ~= "gitlab_duo"
            end)
            :totable()
        vim.lsp.enable(servers)
    end,
})

