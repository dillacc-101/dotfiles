
"==============================================================
" Plugggggggins 
call plug#begin()

Plug('preservim/nerdtree')
Plug ('vim-airline/vim-airline-themes')
Plug('vim-airline/vim-airline')
Plug('ap/vim-css-color')
Plug('ycm-core/YouCompleteMe')
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug('dracula/vim')

call plug#end()
"==============================================================

" Colorscheme
colorscheme gruvbox 

"==============================================================
" Compile C and execute
function CompileC()
	!gcc %
	!./a.out
endfunction
"==============================================================

" =================== General Keybinds ========================
map <C-k> :%s//g<Left><Left>
map mm :w<CR>
map <C-h> :vsp 
map <C-l> :call CompileC()<CR>

filetype plugin on
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
"let g:instant_markdown_browser = 'brave --new-window'
map <C-m> :InstantMarkdownPreview<CR>
"==============================================================

" ======== Config =========
set relativenumber number
set nowrap
set termguicolors
set viminfo="$XDG_DATA_HOME/vim/viminfo"
highlight Comment cterm=italic gui=italic

" Airline theme
autocmd	vimenter * AirlineTheme dracula 

" NERDTree Configuration
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 
"==============================================================
