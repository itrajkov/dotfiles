syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set clipboard=unnamedplus
let mapleader = " "
set t_Co=256
set notermguicolors
set encoding=utf-8
set number relativenumber
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

nnoremap <silent> <esc> :noh<cr><esc>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

vnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
map <leader>o- <cmd>vEx<cr>


call plug#begin()
"Telescopic johnson Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'anott03/nvim-lspinstall'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'alessandroyorba/alduin'
Plug 'arzg/vim-colors-xcode'
Plug 'srcery-colors/srcery-vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mboughaba/i3config.vim'
call plug#end()

lua require("ivche")

" Theme
syntax enable
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
highlight ColorColumn ctermbg=0 guibg=grey
hi SignColumn guibg=none
hi CursorLineNR guibg=None
highlight Normal guibg=none
" highlight LineNr guifg=#ff8659
" highlight LineNr guifg=#aed75f
highlight LineNr guifg=#5eacd3
highlight netrwDir guifg=#5eacd3
highlight qfFileName guifg=#aed75f
hi TelescopeBorder guifg=#5eacd
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

" Language servers
set completeopt=menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua << EOF
require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
require'lspconfig'.pyright.setup{ on_attach=require'completion'.on_attach }
require'lspconfig'.vuels.setup{ on_attach=require'completion'.on_attach }
EOF


let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

"Telescope config
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

