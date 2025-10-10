return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/nvim-cmp'},
    },

    config = function()
        local servers = {
            'clangd',
            'cmake'
        }

        local lspKeys = function(client, bufnr)
            local opts = {buffer = bufnr, remap = false}

            vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set('n', '<leader>vd', function() vim.lsp.buf.open_float() end, opts)
            vim.keymap.set('n', '[d', function() vim.lsp.buf.goto_next() end, opts)
            vim.keymap.set('n', ']d', function() vim.lsp.buf.goto_prev() end, opts)
            vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
            vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

        end

        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = servers,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        vim.lsp.config('*', {
            capabilities = capabilities,
        })

        vim.lsp.enable(servers)

        local lsp_group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true })
        vim.api.nvim_create_autocmd('LspAttach', {
            group = lsp_group,
            desc = 'Set buffer-local keymaps and options after an LSP client attaches',
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end
                lspKeys(client, bufnr)

                if client.server_capabilities.completionProvider then
                    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'
                end
            end,
        })



        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}

        cmp.setup({
            sources = {
                {name = 'path'},
                {name = 'nvim_lsp'},
                {name = 'nvim_lua'},
                {name = 'buffer', keyword_length = 3},
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-l>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
        })

        -- setting for diagnostics to show virtual text for errors and warnings
        vim.diagnostic.config({
            virtual_text = {
                prefix = '●',
                spacing = 2,
            },
            signs = true,
        })

        -- Lua config, set vim as global to avoid undefined variable warning
        vim.lsp.config('lua_ls', {
            on_attach = function(client, bufnr)
                lspKeys(client, bufnr)
            end,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                },
            },
        })
    end
}
