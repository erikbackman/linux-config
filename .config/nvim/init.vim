"colorscheme base16-gruvbox-dark-hard
"colorscheme retrobox
"colorscheme base16-tomorrow-night
colorscheme base16-default-dark
"colorscheme base16-material-darker

set termguicolors
set relativenumber
set signcolumn=yes
set tags=./tags;,tags;

set sj=-50

set textwidth=0
set wrapmargin=0
set wrap
set linebreak

set incsearch
augroup vim-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END


lua require('plugins')
lua require('init')
autocmd BufRead *.zig :TSBufEnable highlight
autocmd BufRead *.vim :TSBufEnable highlight
"autocmd BufRead *.c :TSBufEnable highlight
