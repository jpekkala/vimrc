set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_by_filename = 1
"Plugin 'Valloric/YouCompleteMe'
let g:ycm_auto_trigger = 0
Plugin 'scrooloose/nerdtree'
let g:NERDTreeMinimalUI = 1
Plugin 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_gui_startup = 0
"Plugin 'scrooloose/syntastic'
let g:syntastic_check_on_wq = 0 "do not run syntax check when exiting vim
let g:syntastic_js_checkers = ["jshint"] "do not use jslint
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
imap § <Plug>snipMateNextOrTrigger
smap § <Plug>snipMateNextOrTrigger
call vundle#end()

set autochdir
" whitespace
set expandtab
set ts=4
set sw=4 "use ts value
set softtabstop=4

set hlsearch

filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

source $VIMRUNTIME/mswin.vim
behave mswin

nunmap <C-a>
imap <C-Del> <C-O>de
let mapleader=" "
noremap <Leader>t :YcmCompleter GetType<CR>
noremap <Leader>d :YcmCompleter GetDoc<CR>

set guitablabel=%t\ %M
map <C-t> :NERDTreeTabsToggle<CR>
set guioptions-=T

" if the file is already open in another Vim instance, focus that
function FocusExisting()
    for server in split(serverlist())
        if server != v:servername
            let path = remote_expr(server, "expand('%:p')")
            if path == expand('%:p')
                call remote_send(server, ":call foreground()<CR>")
                let v:swapchoice='a'
            endif
        endif
    endfor
endfunction
autocmd SwapExists * :call FocusExisting()

if has("gui_running")
    set columns=130
    set lines=40
endif

if has("unix")
    " maximize/restore window on space+space
    noremap <Leader><Leader> :call system('wmctrl -i -b toggle,maximized_vert,maximized_horz -r '.v:windowid)<CR>

    set dictionary=-/usr/share/dict/words dictionary+=/usr/share/dict/words
    map <C-e> :silent !nautilus %:p:h<CR>
endif

autocmd FileType javascript :set tw=118
autocmd FileType html :set tw=0
filetype plugin indent on

" adds AngularJS $inject above a function declaration
command Inject execute 'normal yyP^dawdaw' | .s/\<\([a-zA-Z_$]*\)\>/'\1'/g | .s/(/[/ | .s/)\s*{$/];/ | nohl | normal Pwi.$inject = <ESC> 

autocmd BufEnter * lcd %:p:h
