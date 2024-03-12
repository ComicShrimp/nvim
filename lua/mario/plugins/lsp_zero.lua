return {
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependecies = {
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            -- Needed to declare before lsp configuration
            lsp_zero.extend_lspconfig()

            -- to learn how to use mason.nvim with lsp-zero
            -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    -- Javascript/Typescript
                    "eslint",
                    "tsserver",
                    -- "prettier", disabled because it dont have an entry in mason-lspconfig.nvim. Must be installed manually

                    -- Rust
                    "rust_analyzer",
                    -- Lua
                    "lua_ls",
                    -- "luacheck", disabled because it dont have an entry in mason-lspconfig.nvim. Must be installed manually
                    -- Python
                    -- "pyright", disabled because it dont have an entry in mason-lspconfig.nvim. Must be installed manually
                    "ruff_lsp",
                    -- Docker
                    "dockerls",
                    "docker_compose_language_service",
                    -- Tailwind
                    "tailwindcss",
                    -- Vue
                    "vuels",
                    -- Others
                    "jsonls",
                },
                handlers = {
                    lsp_zero.default_setup,
                },
            })

            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                })
            })

            lsp_zero.set_preferences({
                suggest_lsp_servers = true,
                sign_icons = {
                    error = 'E',
                    warn = 'W',
                    hint = 'H',
                    info = 'I'
                }
            })

            lsp_zero.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts, "Goto definition")
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts, "Show hover")
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts,
                    "Search workspace symbols")
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts, "Open diagnostics")
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts, "Next diagnostic")
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts, "Previous diagnostic")
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts, "Code action")
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts, "Find references")
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts, "Rename")
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts, "Signature help")
                vim.keymap.set("n", "<leader>gf", function() vim.lsp.buf.format() end, opts, "Format code")
            end)

            lsp_zero.setup()

            vim.diagnostic.config({
                virtual_text = true
            })
        end
    },
}
