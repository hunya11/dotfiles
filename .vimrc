" ##################
"     NeoBundle
" ##################

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'plasticboy/vim-markdown'         " syntax highlight for markdown.
NeoBundle 'kannokanno/previm'               " markdown previw.
NeoBundle 'scrooloose/nerdtree'             " dict tree.
NeoBundle 'jistr/vim-nerdtree-tabs'         " nerdtree's plugin. shared tree between tabs.
NeoBundle 'bronson/vim-trailing-whitespace' " fixed whitespace
NeoBundle 'tomasr/molokai'                  " colorscheme

if has('lua')
    NeoBundle 'Shougo/neocomplete.vim'      " complement
    NeoBundle "Shougo/neosnippet"           " snippet
    NeoBundle 'Shougo/neosnippet-snippets'  " snippet list
endif

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" ##########################
"      display
" ##########################
set number
set showmatch
syntax on
colorscheme default
highlight Comment ctermfg=LightGreen

" ##################################
"      tab space
" ##################################
set smarttab
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=2

" ##########################
"      stop beep
" ##########################
set vb t_vb=

" ##########################
"      back space
" ##########################
set backspace=indent,eol,start

" ##########################
"      key mapping
" ##########################

" input double space for markdown
imap <C-j> <Esc><S-a><Space><Space><CR>

" easy move between window
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sv gT
nnoremap sm gt

" function key
nnoremap <F3> : noh<CR>

" ##########################
"      au
" ##########################
au BufRead,BufNewFile *.md   set filetype=markdown
au BufRead,BufNewFile *.fcgi set filetype=perl
au BufRead,BufNewFile *.tmpl set filetype=html
au BufRead,BufNewFile *.tx   set filetype=html

" ##########################
"      vim-markdown
" ##########################
if neobundle#is_installed('vim-markdown')
    let g:vim_markdown_folding_disabled = 1
endif

" ##################################
"      NERDtree, NERDtree-tabs
" ##################################
if neobundle#is_installed('nerdtree')
    autocmd vimenter * NERDTreeTabsOpen
    let NERDTreeShowHidden=1
    nnoremap <F4> : NERDTreeTabsToggle<CR>
endif

" ##################################
"      molokai
" ##################################
if neobundle#is_installed('molokai')
    colorscheme molokai
    set t_Co=256
    syntax enable
endif

" ##################################
"      neocomplete
" ##################################
if neobundle#is_installed('neocomplete.vim')
    "Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

    " snippet
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

endif
