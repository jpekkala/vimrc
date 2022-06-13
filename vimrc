set nocompatible
set nomodeline
filetype off

" PLUGINS
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'posva/vim-vue'
Plugin 'tpope/vim-surround'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_by_filename = 1
"Plugin 'tomtom/tlib_vim'
call vundle#end()

" WHITESPACE
set expandtab
set ts=4
set sw=4
set softtabstop=4

" GENERAL
source $VIMRUNTIME/mswin.vim
behave mswin
filetype plugin on
filetype plugin indent on
syntax on
set hlsearch
set autochdir
autocmd BufEnter * lcd %:p:h

" KEYMAP
nunmap <C-a>
imap <C-Del> <C-O>de
let mapleader=" "
noremap <Leader>t :YcmCompleter GetType<CR>
noremap <Leader>d :YcmCompleter GetDoc<CR>

" GUI
set guitablabel=%t\ %M
set guioptions-=T
if has("gui_running")
    set columns=130
    set lines=40
endif

" JAVASCRIPT
autocmd FileType javascript :set tw=118
autocmd FileType html :set tw=0
filetype plugin indent on
" adds AngularJS $inject above a function declaration
command Inject execute 'normal yyP^f(bd^daw' | .s/\<\([a-zA-Z_$]*\)\>/'\1'/g | .s/(/[/ | .s/)\s*{$/];/ | nohl | normal Pwi.$inject = <ESC> 

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

" LINUX
if has("unix")
    " maximize/restore window on space+space
    noremap <Leader><Leader> :call system('wmctrl -i -b toggle,maximized_vert,maximized_horz -r '.v:windowid)<CR>

    set dictionary=-/usr/share/dict/words dictionary+=/usr/share/dict/words
    map <C-e> :silent !caja %:p:h<CR>
endif
