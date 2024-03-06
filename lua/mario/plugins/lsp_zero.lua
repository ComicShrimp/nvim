return {

	{"neovim/nvim-lspconfig"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/nvim-cmp"},
	{"L3MON4D3/LuaSnip"},
	--- Uncomment the two plugins below if you want to manage the language servers from neovim
	{"williamboman/mason.nvim"},
	{"williamboman/mason-lspconfig.nvim"},
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
				lsp_zero.default_keymaps({buffer = bufnr})
			end)

			-- to learn how to use mason.nvim with lsp-zero
			-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {

					"tsserver",
					"eslint",
					"rust_analyzer",
					"lua_ls",
					"ruff_lsp",
					"dockerls",
					"docker_compose_language_service",
					"jsonls",
					"marksman",
					"tailwindcss",
					"volar",
				},
				handlers = {
					lsp_zero.default_setup,
				},
			})
		end
	},
}
