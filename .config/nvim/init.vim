let g:tex_flavor = 'latex'

syntax on

set relativenumber
set number
set nohlsearch
set hidden
set noerrorbells
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect

function RunPy()
	!python3 %
endfunction

function CompileC()
	!gcc -g -Wall -o /tmp/a.out %
	!/tmp/a.out
endfunction

"COC
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~ '\s'
endfunction


call plug#begin()

Plug 'lervag/vimtex'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug('preservim/nerdtree')
Plug('vim-airline/vim-airline')
Plug('ap/vim-css-color')
Plug ('tpope/vim-fugitive')

Plug 'branwright1/salvation-vim'
Plug 'ghifarit53/daycula-vim' , {'branch' : 'main'}
Plug 'ghifarit53/tokyonight-vim'
Plug('dracula/vim')
Plug('franbach/miramare')
Plug('lewis6991/moonlight.vim')
Plug('gruvbox-community/gruvbox')
Plug('gryf/wombat256grf')
Plug('severij/vadelma')
Plug ('joshdick/onedark.vim')
Plug ('kaicataldo/material.vim') 
Plug ('vim-airline/vim-airline-themes')
call plug#end()

let g:gruvbox_contrast_dark = 'hard'
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
let g:daycula_enable_italic = 1
colorscheme tokyonight 
highlight Comment cterm=italic gui=italic

" No background
" hi Normal guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE

" Airline theme
autocmd	vimenter * AirlineTheme tokyonight 

" NERDTree Configuration
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

let mapleader = " "

map <C-k> :%s//g<Left><Left>
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
map mm :w<CR>
map <C-h> :vsp 
map <C-l> :call CompileC()<CR>
map <C-l>p :call RunPy()<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-p> :FZF<CR>
nnoremap <leader>cs :CocSearch <C-R>=expand("<cword>")<CR><CR>
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>ct <Plug>(coc-type-definition)
nmap <leader>ci <Plug>(coc-implementation)
nmap <leader>cr <Plug>(coc-references)
