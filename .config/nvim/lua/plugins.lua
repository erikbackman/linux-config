vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
	-- use 'erikbackman/brightburn.vim'
	use {
		'nvim-treesitter/nvim-treesitter',
		config = function() require 'nvim-treesitter.configs'.setup {
			ensure_installed = { "zig", "c", "vimdoc" },
			auto_install = false,
			highlight = { 
				enable = true, 
			},
		} end
	}
	use { 'doums/darcula' }
	use { 'm6vrm/gruber.vim' }
	use { 'CreaturePhil/vim-handmade-hero' }
	use { 'deparr/tairiki.nvim' }
	use { 'danilo-augusto/vim-afterglow' }
	use { 'andreasvc/vim-256noir' }
	use { 'bhrown/brown.vim' }
	use { 'phha/zenburn.nvim' }
	use { 'Nequo/palefire-nvim' }
	use { 'chriskempson/base16-vim' }

	--use { 
	--	'norcalli/nvim-colorizer.lua',
	--	config = function() require 
	--		'colorizer'.setup() 
	--	end
	--}
end)
