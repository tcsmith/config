" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

if has("gui_running")
    colorscheme evening
else
    set background=dark
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switc W=syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" set tmp, swap, backup directories, note this also works on windows ~
" gets converted to the users home directory correctly
set backupdir=~/tmp
set dir=~/tmp

set ignorecase
set smartcase
set smartindent
set smarttab
set expandtab
set shiftwidth=4
set tabstop=4
set showmatch
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}k@=\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" lhs comments
map ,/ :s/^/\/\//<CR> <ESC>:nohlsearch <CR>  
map ,c :s/^\/\///<CR> <ESC>:nohlsearch <CR>

" windows specific options
" launch the current file in a command window and close the command window
if has('win32')
    nnoremap <silent> <F5> :w <bar> :!start cmd /c "%:p:r" <CR>  
else
    " non windows things
endif

" comment block mappings based on filetype
function CommentIt ()
    if &filetype == "dosbatch"
        vmap <silent> +# :s/^/REM /<CR> :noh<CR>
        vmap <silent> _# :s/^REM //<CR> :noh<CR>
    endif
endfunction
autocmd BufEnter * call CommentIt ()

" esc clears any search highlights
"nnoremap <silent> <esc> :noh<cr><esc>
" had to change this to Enter key so that it doesnt start in replace mode
" see:
" https://stackoverflow.com/questions/20471461/why-is-my-vim-starting-in-replacemode 
nnoremap <Enter> :nohlsearch<CR>

" set the initial window size
if has('gui_running')
    set lines=30 columns=120
endif

" ctrlp plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
