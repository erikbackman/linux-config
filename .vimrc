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
nnoremap <leader>t :tag<space>
nnoremap <leader>. <C-]><CR>
inoremap <C-i> <C-x><C-]>
nnoremap <leader>bd :bp\|bd #<CR>
nnoremap <leader>bb :e #<CR>
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprev<CR>
nnoremap <leader>co :cgetfile<space>log\|copen<CR>
nnoremap <leader>ck :cclose<CR>\|<C-w><C-p>

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
		const ext = expand('%:e')
		if ext != ""
				execute $'vimgrep {pattern} *.{ext}'
		endif
enddef

command! -nargs=1 MyGrep MyGrep("<args>")
nnoremap <leader>g :MyGrep<space>
nnoremap <leader>cc :Make!<CR>

