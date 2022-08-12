" Vundle configuration
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'

" All of your Plugins must be added before the following linE
call vundle#end()            " required
filetype plugin indent on    " required

" Vim environment options
let python_highlight_all=1
syntax on
set wrap
set expandtab
set number
set tabstop=4
set shiftwidth=4
set visualbell
set noerrorbells
set textwidth=120
set t_Co=256
set autoindent
set smartindent
set showmatch
set splitbelow
set splitright

" UTF-8 encoding
set enc=utf-8

" YouCompleteMe options
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1

" Maps
nmap <F2> :w<CR>
imap <F2> <ESC>:w<CR>i
map<F3> :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>
map<F4> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
nmap<F5> :wq<CR>
imap<F5> <ESC>:wq<CR>
inoremap( ()<ESC>:let leavechar=")"<CR>i
inoremap[ []<ESC>:let leavechar="]"<CR>i
inoremap" ""<ESC>:let leavechar="""<CR>i
inoremap' ''<ESC>:let leavechar="'"<CR>i
inoremap{ {}<ESC>:let leavechar="}"<CR>i
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
