" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
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
let &guioptions = substitute(&guioptions, "t", "", "g")

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
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  
  autocmd BufEnter * lcs %:p:h




  augroup END

else

  set autoindent		" always set autoindenting on
  set autochdir

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


"	MY OWN SETTINGS

set go-=m
set go-=T

set ruler
set vb t_vb=
set virtualedit=all
set tabstop=4
set shiftwidth=4
"set makeprg=mingw32-make
if has("autocmd")
" autocmd BufNewFile,BufRead *.py setlocal expandtab
  au BufRead,BufNewFile *.hta setlocal filetype=vb

  au BufRead,BufNewFile *.pri setlocal filetype=xml
  au BufRead,BufNewFile *.prr setlocal filetype=xml
  au BufRead,BufNewFile *.prt setlocal filetype=xml

  au filetype c compiler MinGW
  au filetype cpp compiler MinGW

  au BufRead,BufNewFile *.csproj compiler MSBuild
  au filetype cs compiler MSBuild

  
  au filetype vb map <buffer> <F5> <Esc>:!%<CR>
  au filetype python map <buffer> <F5> <Esc>:!%<CR>

  autocmd filetype python setlocal expandtab

  autocmd filetype c setlocal dict+=$vim\dictionaries\c.dic
  autocmd filetype cpp setlocal dict+=$vim\dictionaries\cpp.dic
  autocmd filetype cs setlocal dict+=$vim\dictionaries\cs.dic
  autocmd filetype html setlocal dict+=$vim\dictionaries\html.dic
  autocmd filetype python setlocal dict+=$vim\dictionaries\python.dic
  autocmd filetype sql setlocal dict+=$vim\dictionaries\sql.dic
  autocmd filetype vb setlocal dict+=$vim\dictionaries\vb.dic

  autocmd BufRead,BufNewFile *.* let b:VCSCommandVCSType='SVN'
endif
color torte

command Cmd ConqueTerm cmd

let g:ftplugin_sql_omni_key = 'ã' "This is actuall <A-C>
command! -complete=dir -nargs=* -count=0 Ex call netrw#Explore(<count>,0,0+<bang>0,<q-args>)
" DBEXT SETTINGS
source $VIM/dbextProfiles.vim

" VCSCommand SETTINGS
"set statusline=%<%f\ %{VCSCommandGetStatusLine()}\ %h%m%r%=%l,%c%V\ %P

" Fugitive SETTINGS
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
autocmd BufReadPost fugitive://* set bufhidden=delete
noremap <Leader>gc <Esc>:Gcommit<Cr>
noremap <Leader>gs <Esc>:Gstatus<Cr>

filetype indent on

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

let g:ConqueTerm_ToggleKey = '<F8>'
let g:ConqueTerm_InsertOnEnter = 0
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_ReadUnfocused = 1


if has('win32')
	silent execute '!mkdir "'.$VIMRUNTIME.'/temp"'
	silent execute '!del "'.$VIMRUNTIME.'/temp/*~"'
	set backupdir=$VIMRUNTIME/temp//
	set directory=$VIMRUNTIME/temp//
elseif has('unix')
	silent execute '!mkdir -p ~/vimtmp'
	silent execute '!rm -f ~/vimtmp/*'
	set backupdir=~/vimtmp//
	set directory=~/vimtmp//
endif
	

nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

nnoremap <A-x> <C-a>
inoremap <A-e> <C-y>



source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction



