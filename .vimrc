vim9script

filetype plugin indent on
runtime macros/matchit.vim

set termguicolors
set t_Co=256
syntax enable
colorscheme citrus

set tabstop=4
set relativenumber
set wildmenu
set wildmode=longest:full,full
set autochdir

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
nnoremap <leader>cc :Make!<CR>

inoremap jk <esc>
set timeoutlen=200
nnoremap ö <esc>
inoremap ö <esc>
vnoremap ö <esc>
xnoremap ö <esc>
snoremap ö <esc>
cnoremap ö <C-C>
onoremap ö <esc>
def MyGrep(pattern: string): void
		set path=$'{$PWD}'
		const ext = expand('%:e')
		if ext != ""
				execute $'vimgrep {pattern} *.{ext}'
		endif
enddef

command! -nargs=1 MyGrep MyGrep("<args>")
nnoremap <leader>gg :MyGrep<space>

def FollowLink(): void
		const link = expand('<cWORD>')
		call system($'firefox {link}')
enddef

command! -nargs=0 FollowLink FollowLink()
nnoremap <leader>gl :FollowLink<CR>
