vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
	-- use 'erikbackman/brightburn.vim'
	use {
		'nvim-treesitter/nvim-treesitter',
		config = function() require 'nvim-treesitter.configs'.setup {
			ensure_installed = { "zig", "c", "vimdoc" },
			auto_install = false,
			highlight = { 
				enable = false, 
			},
		} end
	}
	use { 'chriskempson/base16-vim' }

	--use { 
	--	'norcalli/nvim-colorizer.lua',
	--	config = function() require 
	--		'colorizer'.setup() 
	--	end
	--}
end)
