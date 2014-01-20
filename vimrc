set nocompatible
" Syntax highlighting on!
syntax on
" Some stuff about reading file types and indentations
filetype plugin indent on
" Colorscheme found in ~/.vim/colors
colorscheme monokai
" Pathogen bundle loader
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
" Line numbers
set number
" Current line highlighting
set ruler
" Disable arrows for navigation, much better for you!
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
set paste
" key mapping for google search
function! Google()
	call inputsave()
	let searchterm = input('Google: ')
	call inputrestore()
	return searchterm
endfunction
map © <ESC>:! /usr/bin/open -a "/Applications/Google Chrome.app" 'https://google.com/search?q=<C-R>=Google()<CR>'<CR><CR>
" generic
set encoding=utf-8
" show the command line
set showcmd
" hmm this must be cursor line highlighting... so what is set ruler...?
set cursorline
set backspace=indent,eol,start
set laststatus=2
set scrolloff=999
set nocompatible

" smart case search
set ignorecase
set smartcase
set autoindent
set tabstop=2 
set shiftwidth=2 
set expandtab
set smarttab
set paste
set cinkeys=0{,0},:,0#,!^F
" incremental search looks cool
set incsearch
" remap ctrl+c to Esc
imap <c-c> <Esc>
" turn off irritating noises
set noerrorbells
set showmatch
augroup mkd
	autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
augroup END
set clipboard=unnamed

" 'quote' a word
nnoremap qw :silent! normal mpea'<Esc>bi'<Esc>`pl
" double quote a word
nnoremap qd :silent! normal mpea"<Esc>bi"<Esc>`pl
" remove quotes from a word
nnoremap wq :silent! normal mpeld bhd `ph<CR>

 " persistent undo
 set undofile
 set undodir=~/.tmp

 " backup to ~/.tmp 
 set backup 
 set backupdir=~/.tmp
 set directory=~/.tmp
 set writebackup
 set vb
