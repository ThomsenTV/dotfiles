return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		local treesitter = require("nvim-treesitter")
		treesitter.setup()
		treesitter.install({
			"lua",
			"c",
			"vim",
			"vimdoc",
			"markdown",
			"haskell",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua",
				"c",
				"vim",
				"vimdoc",
				"markdown",
				-- "haskell",
			},
			callback = function()
				-- Syntax highlighting
				vim.treesitter.start()
				-- Treesitter indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
		-- Auto install c:NoYam4683 via reddit
		vim.api.nvim_create_autocmd('FileType', {
			callback = function(ev)
				local lang = vim.treesitter.language.get_lang(ev.match)
				local available_langs = require('nvim-treesitter').get_available()
				local is_available = vim.tbl_contains(available_langs, lang)
				if is_available then
					local installed_langs = require('nvim-treesitter').get_installed()
					local installed = vim.tbl_contains(installed_langs, lang)
					if not installed then
						require('nvim-treesitter').install(lang):wait()
					end
					vim.treesitter.start()
					require('nvim-treesitter').indentexpr()
				end
  end,
})
	end,
}

