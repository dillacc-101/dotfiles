
" Plugggggggins 
call plug#begin()

Plug('preservim/nerdtree')
Plug 'vim-airline/vim-airline-themes'
Plug('vim-airline/vim-airline')
Plug('ap/vim-css-color')

call plug#end()

" Config
set relativenumber number
set nowrap
set termguicolors

" Colorscheme
colorscheme gruvbox 

" NERDTree Configuration

 autocmd	vimenter * AirlineTheme minimalist 
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

" Keybinds
map <C-k> :%s//g<Left><Left>
map <C-s> :w<CR>
map <C-h> :vsp 

" Airline theme

