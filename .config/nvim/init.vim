"==============================================================
" Plugggggggins 
call plug#begin()

Plug('preservim/nerdtree')
Plug ('vim-airline/vim-airline-themes')
Plug('vim-airline/vim-airline')
Plug('ap/vim-css-color')
"Plug('ycm-core/YouCompleteMe')
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug('dracula/vim')
Plug('franbach/miramare')
Plug ('tpope/vim-fugitive')
"Plug('ctrlpvim/ctrlp.vim')
Plug ('tpope/vim-surround')
Plug('lewis6991/moonlight.vim')
Plug('gruvbox-community/gruvbox')
Plug('gryf/wombat256grf')
Plug('severij/vadelma')
Plug ('joshdick/onedark.vim')
Plug ('kaicataldo/material.vim') 
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
call plug#end()
"==============================================================
set termguicolors 
colorscheme miramare 
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
highlight Comment cterm=italic gui=italic

" ======== Config =========
set relativenumber number
set nowrap
set viminfo="$XDG_DATA_HOME/vim/viminfo"

" Airline theme
autocmd	vimenter * AirlineTheme minimalist 

" NERDTree Configuration
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

"COC
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~ '\s'
endfunction
" =============================================================
" Run python
function RunPy()
	!python3 %
endfunction

" Compile C and execute
function CompileC()
	!gcc -o /tmp/a.out %
	!/tmp/a.out
endfunction

" Compile LaTeX
function LaTeX()
	w
	!pdflatex %
endfunction

" =================== General Keybinds ========================
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
map <leader>t :wincmd v<bar> Ex <bar> vertical resize 30 <CR>
map <leader>l :call LaTeX()<CR><CR>
map <C-n> :NERDTreeToggle<CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

filetype plugin on
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
"let g:instant_markdown_browser = 'brave --new-window'
map <C-m> :InstantMarkdownPreview<CR>
"==============================================================
