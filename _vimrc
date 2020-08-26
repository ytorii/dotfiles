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
set fileformats=unix,dos,mac

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Use clipboard
set clipboard=unnamed,autoselect

if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  " Add or remove your Bundles here:
  " Helping opening files
  call dein#add('Shougo/unite.vim')
  " Displays recently opned files with unite.vim
  call dein#add('Shougo/neomru.vim')
  " Displays directories ans files by tree form 
  call dein#add('scrooloose/nerdtree')
  " Supports additional command for Rails
  call dein#add('tpope/vim-rails')
  " Completes end clause for Ruby codes
  call dein#add('tpope/vim-endwise')
  " Replaces single quotes and duoble quotes
  call dein#add('tpope/vim-surround')
  " A fancy status line
  call dein#add('itchyny/lightline.vim')
  
  " Markdown Previewer
  call dein#add('tpope/vim-markdown')
  call dein#add('tyru/open-browser.vim')
  call dein#add('thinca/vim-quickrun')
  
  call dein#add('w0rp/ale')
  
  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev' : '3787e5' })
  
  " The Silver Shearcher
  call dein#add('rking/ag.vim')
  
  " HTML Tag Expander
  call dein#add('mattn/emmet-vim')
  
  " Syntax highlight for js
  call dein#add('jacoborus/tender.vim')
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  call dein#add('rust-lang/rust.vim')
  
  call dein#add('Quramy/tsuquyomi')
  call dein#add('leafgarland/typescript-vim')

  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on

syntax enable

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
inoremap <silent> jj <ESC>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable
  set nohlsearch
  set background=dark
  colorscheme tender
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
      \  'javascript': ['eslint'],
      \  'ruby': ['rubocop']
      \  }
let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \  }
highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
let g:ale_sign_error = 'X' " could use emoji
let g:ale_sign_warning = '?' " could use emoji
let g:ale_statusline_format = ['X %d', '? %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'

" Enables syntax highlight for js file (not only jsx)
let g:jsx_ext_required = 1

" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

" disable safe write to enable HMR on percel 
set backupcopy=yes

" Indent highlighting settings
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=black ctermbg=black

au FileType plantuml command! OpenUml :!chromium-browser %
