"--- vimrc ---------------------------------------------------------------------
"started: ca. 2011
"name:    brandon krull
"email:   btkrull@gmail.com

syntax enable 
"--- plugins -------------------------------------------------------------------
execute pathogen#infect()
execute pathogen#helptags()
let g:ctrlp_map='<C-p>'
let g:ctrlp_cmd='CtrlP'
let g:tex_flavor='latex'
let g:Tex_GotoError=1
let g:TCLevel=5
let g:Tex_ViewRule_pdf='open -a Preview'
let g:Tex_CompileRule_pdf='pdflatex --interaction=nonstopmode $*'
let g:Tex_useMakefile=1
filetype plugin indent on

"--- basic options -------------------------------------------------------------
colorscheme anotherdark
set autoindent
set autoread
set background=dark
set backspace=eol,start,indent
set cryptmethod=blowfish
set expandtab
set foldmethod=manual
set formatoptions=vt
set grepprg=grep\ -nH\ $*
set hidden
set mouse=a 
set nopaste
set number
set ruler
set shiftwidth=4
set smarttab
set spelllang=en_us
set splitbelow
set splitright
set tabstop=4
set textwidth=80
set whichwrap+=<,>,h,l
set wildmenu
set viewoptions-=options

"--- autocommands --------------------------------------------------------------
au! bufenter .vimrc source %
au! bufwritepost .vimrc source % " autosource .vimrc after write
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
au bufenter /private/tmp/crontab.* setl backupcopy=yes " crontab fix
au bufenter * if (winnr("$") == 1 
   \ && exists("b:NERDTreeType")  && b:NERDTreeType == "primary") | q | endif
augroup vimrc
   autocmd bufwritepost *
   \   if expand('%') != '' && &buftype !~ 'nofile'
   \|      mkview
   \|  endif
   autocmd bufread *
   \   if expand('%') != '' && &buftype !~ 'nofile'
   \|      silent loadview
   \|  endif
augroup END

augroup encrypted
au!  
" First make sure nothing is written to ~/.viminfo while editing an encrypted file.
    autocmd BufReadPre,FileReadPre *.gpg set viminfo=
" We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre *.gpg set noswapfile

" Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre *.gpg set bin
    autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

" Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost *.gpg set nobin
    autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

" Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
" Undo the encryption so we are back in the normal text, directly after the file has been written.
    autocmd BufWritePost,FileWritePost *.gpg u
augroup END

"--- maps ----------------------------------------------------------------------
let mapleader=","
nmap <leader>v :sp $MYVIMRC<CR>
nmap <silent> <leader>m :make<CR>
nmap <silent> <leader>q :q<CR>
nmap <silent> <leader>s :set spell!<CR>
nmap <silent> <leader>w :w<CR>
nmap <silent> <leader>x :x<CR>
nnoremap <leader>. :CtrlPTag<CR>

"--- vim-latex maps ---
imap <C-b> <Plug>Tex_MathBF
imap <C-c> <Plug>Tex_MathCal
imap <C-i> <Plug>Tex_InsertItemOnThisLine
imap <C-l> <Plug>Tex_LeftRight
imap <C-n> <Plug>IMAP_JumpForward 

map j gj
map k gk
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

"--- functions ----------------------------------------------------------------
function! s:DiffWithSaved() " sp diff working buffer with disk copy
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
