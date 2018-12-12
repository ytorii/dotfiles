" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
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

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Use clipboard
set clipboard=unnamed,autoselect

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved
 
  " Required:
  set runtimepath^=~/.vim/bundle/neobundle.vim/
endif


" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
" Helping opening files
NeoBundle 'Shougo/unite.vim'
" Displays recently opned files with unite.vim
NeoBundle 'Shougo/neomru.vim'
" Displays directories ans files by tree form 
NeoBundle 'scrooloose/nerdtree'
" Supports additional command for Rails
NeoBundle 'tpope/vim-rails'
" Completes end clause for Ruby codes
NeoBundle 'tpope/vim-endwise'
" Replaces single quotes and duoble quotes
NeoBundle 'tpope/vim-surround'
" A fancy status line
NeoBundle 'itchyny/lightline.vim'

" Markdown Previewer
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'w0rp/ale'
" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'ctrlpvim/ctrlp.vim'
" NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" The Silver Shearcher
NeoBundle 'rking/ag.vim'

" HTML Tag Expander
NeoBundle 'mattn/emmet-vim'

" Syntax highlight for js
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'rust-lang/rust.vim'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=10		" keep 50 lines of command line history
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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch
  set background=dark
  colorscheme desert
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

  " Change current working directory automatically
  autocmd BufEnter * silent! lcd %:p:h

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Words completion settings"
set wildmenu wildmode=list:full

" Show the line number."
set number
" Highlighting the cursor line."
set cursorline
" Setting indent to two space characters."
set expandtab
set tabstop=2
set shiftwidth=2
set viminfo='20,\"1000
" No backup files
set nobackup
" Setting for lightline.vim
let g:lightline = {
      \ }
let g:lightline = {
  \  'colorscheme': 'seoul256',
  \  'active': {
  \    'left': [
  \      ['mode', 'paste'],
  \      ['readonly', 'filename', 'modified', 'ale'],
  \    ]
  \  },
  \  'component_function': {
  \    'ale': 'ALEGetStatusLine'
  \  }
  \ }

set laststatus=2

" -------------------- QuickRun ----------------------------- "
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = { 'outputter': 'browser' }

" ------------------------- ALE ----------------------------- "
" Asynchronous Lint Engine (ALE)
" Limit linters used for JavaScript.
let g:ale_linters = {
      \  'javascript': ['flow', 'eslint'],
      \  'ruby': ['rubocop']
      \  }
let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \  }
highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = 'X' " could use emoji
let g:ale_sign_warning = '?' " could use emoji
let g:ale_statusline_format = ['X %d', '? %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'

" Enables syntax highlight for js file (not only jsx)
let g:jsx_ext_required = 0

" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>
