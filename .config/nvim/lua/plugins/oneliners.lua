return {
	{-- Better :!git execution
		"tpope/vim-fugitive",
	},
	{-- Show CSS colors e.g. #fa8072
		'brenoprata10/nvim-highlight-colors',
		config = function()
			require('nvim-highlight-colors').setup({
				render = 'foreground',

			})
		end	
	},
}
