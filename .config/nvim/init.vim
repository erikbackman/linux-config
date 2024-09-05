"colorscheme base16-gruvbox-dark-hard
"colorscheme retrobox
colorscheme base16-tomorrow-night
"colorscheme salvation
"colorscheme base16-default-dark
"colorscheme base16-zenburn

set termguicolors
set relativenumber
set signcolumn=yes
set tags=./tags;,tags;

set scrolloff=999
"set sj=-50

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
filetype plugin on
filetype indent on
autocmd BufNewFile,BufRead *.zig :TSBufEnable highlight
autocmd BufNewFile,BufRead *.vim :TSBufEnable highlight
autocmd BufNewFile,BufRead *.c :TSBufEnable highlight

command! W :w
"autocmd BufRead *.c :TSBufEnable highlight
