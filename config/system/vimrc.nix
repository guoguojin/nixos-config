{pkgs}:
{
    config = ''
       " Force vim to load python3 first

       set nocompatible
       set history=10000
       
       " Fix backspace indent
       set backspace=indent,eol,start

       filetype plugin indent on

       set encoding=utf-8
       set fileencoding=utf-8
       set fileencodings=utf-8
       set ttyfast
       set autowrite

       filetype indent on
       set lazyredraw
       set showmatch
       set rnu

       "Disable swap file
       set noswapfile

       " Undo
       set undodir=~/.vim/undodir
       set undofile

       "" Tabs. May be overridden by autocmd rules
       set tabstop=4
       set softtabstop=0
       set shiftwidth=4
       set expandtab
       
       "" Map leader to ,
       let mapleader=','
       
       "" Enable hidden buffers
       set hidden
       
       " Show cursor line
       set cursorline
       
       "" Searching
       set hlsearch
       set incsearch
       set ignorecase
       set smartcase

       set fileformats=unix,dos,mac
       
       if exists('$SHELL')
           set shell=$SHELL
       else
           set shell=/bin/sh
       endif

       " session management
       let g:session_directory = "~/.vim/session"
       let g:session_autoload = "no"
       let g:session_autosave = "no"
       let g:session_command_aliases = 1

       "*****************************************************************************
       "" Visual Settings
       "*****************************************************************************
       syntax on
       set ruler
       set number

       if (has("termguicolors"))
        set termguicolors
        let ayucolor="mirage"
       endif

       let no_buffers_menu=1
       silent! colorscheme night-owl
       hi Normal guibg=NONE ctermbg=NONE

       set mousemodel=popup
       set t_Co=256
       set guioptions=egmrti

       "" Disable the blinking cursor.
       set gcr=a:blinkon0
       set scrolloff=3

       "" Status bar
       set laststatus=2

       "" Use modeline overrides
       set modeline
       set modelines=10

       set title
       set titleold="Terminal"
       set titlestring=%F

       set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

       " Search mappings: These will make it so that going to the next one in a
       " search will center on the line it's found in.
       nnoremap n nzzzv
       nnoremap N Nzzzv

       if exists("*fugitive#statusline")
         set statusline+=%{fugitive#statusline()}
       endif

       "" NERDTree configuration
       let g:NERDTreeChDirMode=2
       let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
       let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
       let g:NERDTreeShowBookmarks=1
       let g:nerdtree_tabs_focus_on_files=1
       let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
       let g:NERDTreeWinSize = 50
       let g:NERDTreeShowHidden = 1
       set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
       nnoremap <silent> <F2> :NERDTreeFind<CR>
       nnoremap <silent> <F3> :NERDTreeToggle<CR>

       " terminal emulation
       nnoremap <silent> <leader>sh :terminal<CR>
   
       "" Change colorscheme
       nnoremap <Leader>cn :colorscheme night-owl<CR>
       nnoremap <Leader>ca :colorscheme ayu<CR>


       "" Split
       set splitbelow
       set splitright
       noremap <Leader>h :<C-u>split<CR>
       noremap <Leader>v :<C-u>vsplit<CR>

       "" Git
       noremap <Leader>ga :Gwrite<CR>
       noremap <Leader>gc :Gcommit<CR>
       noremap <Leader>gsh :Gpush<CR>
       noremap <Leader>gll :Gpull<CR>
       noremap <Leader>gs :Gstatus<CR>
       noremap <Leader>gb :Gblame<CR>
       noremap <Leader>gd :Gvdiff<CR>
       noremap <Leader>gr :Gremove<CR>

       " session management
       nnoremap <leader>so :OpenSession<Space>
       nnoremap <leader>ss :SaveSession<Space>
       nnoremap <leader>sd :DeleteSession<CR>
       nnoremap <leader>sc :CloseSession<CR>

       "" Tabs
       nnoremap <Tab> gt
       nnoremap <S-Tab> gT
       nnoremap <silent> <S-t> :tabnew<CR>

       "" Set working directory
       nnoremap <leader>. :lcd %:p:h<CR>

       "" Opens an edit command with the path of the currently edited file filled in
       noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

       "" Opens a tab edit command with the path of the currently edited file filled
       noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

       "" Vmap for maintain Visual Mode after shifting > and <
       vmap < <gv
       vmap > >gv

       "" fzf.vim
       set wildmode=list:longest,list:full
       set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
       let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

       " snippets
       let g:UltiSnipsExpandTrigger="<tab>"
       let g:UltiSnipsJumpForwardTrigger="<tab>"
       let g:UltiSnipsJumpBackwardTrigger="<c-b>"
       let g:UltiSnipsEditSplit="vertical"
       
       " ale
       let g:ale_linters = {}

       " go
       " vim-go
       " run :GoBuild or :GoTestCompile based on the go file
       function! s:build_go_files()
         let l:file = expand('%')
         if l:file =~# '^\f\+_test\.go$'
           call go#test#Test(0, 1)
         elseif l:file =~# '^\f\+\.go$'
           call go#cmd#Build(0)
         endif
       endfunction

       let g:go_list_type = "quickfix"
       let g:go_fmt_command = "goimports"
       let g:go_fmt_fail_silently = 1

       let g:go_highlight_types = 1
       let g:go_highlight_fields = 1
       let g:go_highlight_functions = 1
       let g:go_highlight_methods = 1
       let g:go_highlight_operators = 1
       let g:go_highlight_build_constraints = 1
       let g:go_highlight_structs = 1
       let g:go_highlight_generate_tags = 1
       let g:go_highlight_space_tab_error = 0
       let g:go_highlight_array_whitespace_error = 0
       let g:go_highlight_trailing_whitespace_error = 0
       let g:go_highlight_extra_types = 1

       autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

       augroup completion_preview_close
         autocmd!
         if v:version > 703 || v:version == 703 && has('patch598')
           autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
         endif
       augroup END

       augroup go

         au!
         au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
         au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
         au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
         au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

         au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
         au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
         au FileType go nmap <Leader>db <Plug>(go-doc-browser)

         au FileType go nmap <leader>r  <Plug>(go-run)
         au FileType go nmap <leader>t  <Plug>(go-test)
         au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
         au FileType go nmap <Leader>i <Plug>(go-info)
         au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
         au FileType go nmap <C-g> :GoDecls<cr>
         au FileType go nmap <leader>dr :GoDeclsDir<cr>
         au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
         au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
         au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>

       augroup END

       " ale
       :call extend(g:ale_linters, {
           \"go": ['golint', 'go vet'], })

       set showtabline=2  " Show tabline
       set guioptions-=e  " Don't use GUI tabline

       let g:EasyMotion_do_mapping = 1 " Enable/Disable default easymotion mappings
       let g:EasyMotion_smartcase = 1  " Turn on case insensitive feature
    '';
}