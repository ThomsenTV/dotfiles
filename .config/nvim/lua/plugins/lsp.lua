return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({
				virtual_text  = true,
				severity_sort = true,
				float         = {
					style  = 'minimal',
					border = 'rounded',
					source = 'if_many',
					header = '',
					prefix = '',
				},
				signs         = {
					text = {
						[vim.diagnostic.severity.ERROR] = '✘',
						[vim.diagnostic.severity.WARN]  = '▲',
						[vim.diagnostic.severity.HINT]  = '⚑',
						[vim.diagnostic.severity.INFO]  = '»',
					},
				},
			})

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local buf    = args.buf
					local map    = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end

					map('n', 'K', vim.lsp.buf.hover)
					map('n', 'gd', vim.lsp.buf.definition)
					map('n', 'gD', vim.lsp.buf.declaration)
					map('n', 'gi', vim.lsp.buf.implementation)
					map('n', 'go', vim.lsp.buf.type_definition)
					map('n', 'gr', vim.lsp.buf.references)
					map('n', 'gs', vim.lsp.buf.signature_help)
					map('n', 'gl', vim.diagnostic.open_float)
					map('n', '<F2>', vim.lsp.buf.rename)
					map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end)
					map('n', '<F4>', vim.lsp.buf.code_action)
				end

			})

			-- Haskell
			vim.lsp.config("hls", {
				cmd = { "haskell-language-server-wrapper-2.14.0.0", "--lsp" },
				settings = {
					haskell = {
						formattingProvider = "ormolu",
						cabalFormattingProvider = "cabal-fmt",
					},
				},
			})

			-- vim.lsp.enable("hls")

			-- Lua
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})

			vim.lsp.enable("lua_ls")
		end,
	},
}
