vim9script

filetype plugin indent on
runtime macros/matchit.vim

set termguicolors
set t_Co=256
syntax enable
colorscheme citrus

set mouse=n
set ttymouse=xterm2

set tabstop=8
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set cindent

set relativenumber

set wildmenu
set wildmode=longest:full,full
set wildchar=<Tab>
#set wildoptions=pum
set wildignore=*~,#*#,*.sw?,*.o,*.class,.viminfo,*.pdf,*.mp3,*.gz,*.tgz,*.gif,*.jpg,*.png

set autochdir
set timeoutlen=300

set tags=./tags;,tags;

g:mapleader = " "
inoremap <C-i> <C-x><C-]>
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprev<CR>
nnoremap <leader>t :tag<space>
nnoremap <leader>. <C-]><CR>
nnoremap <leader>bd :bp\|bd #<CR>
nnoremap <leader>bb :e #<CR>
nnoremap <leader>co :cgetfile<space>log\|copen<CR>
nnoremap <leader>ck :cclose<CR>\|<C-w><C-p>
nnoremap <leader>cc :Make<CR>
nnoremap <leader>df 0dt{d%
nnoremap <leader>s :w<CR>

au BufReadPost *.zig nnoremap <leader>cr :Dispatch! zig build run<CR>
au BufReadPost *.zig {
		:iabbrev print! std.debug.print("", .{})
}

set incsearch
augroup vim-incsearch-highlight
		autocmd!
		autocmd CmdlineEnter /,\? :set hlsearch
		autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

nnoremap ö <esc>
inoremap ö <esc>
vnoremap ö <esc>
xnoremap ö <esc>
snoremap ö <esc>
cnoremap ö <C-C>
onoremap ö <esc>

def FollowLink(): void
		const link = expand('<cWORD>')
		call system($'firefox {link}')
enddef
command! -nargs=0 FollowLink FollowLink()
nnoremap <leader>gl :FollowLink<CR>

nnoremap <leader>sp :r ~/.vim/snippets/zig-print<CR>
