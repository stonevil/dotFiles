"NeoBundle Scripts-----------------------------
" Install neobundle
" curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | /bin/bash
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
	set nocompatible
	syntax on
	filetype on
	filetype indent on
	filetype plugin on

	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimshell.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
" NeoBundle 'godlygeek/tabular'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic'

NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'

NeoBundle 'christoomey/vim-tmux-navigator'

NeoBundle 'bling/vim-airline'

NeoBundle 'dietsche/vim-lastplace'

" Enable clipboard over network connection. https://github.com/wincent/clipper is required
NeoBundle 'wincent/vim-clipper'

" Enable write a file containing the current state of Vim
" NeoBundle 'tpope/vim-obsession'

" Asynchronous execution library
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'majutsushi/tagbar'

"" Go Lang Bundle
NeoBundle 'fatih/vim-go'
" NeoBundle 'nsf/gocode', {'rtp': 'vim/'} " Install plugin from https://github.com/nsf/gocode

"" C/C++ Bundle
NeoBundle 'vim-scripts/c.vim'

"" Swift Bundle
NeoBundle 'kballard/vim-swift'
" NeoBundle 'keith/swift.vim'

"" HTML Bundle
" NeoBundle 'amirh/HTML-AutoCloseTag'
" NeoBundle 'hail2u/vim-css3-syntax'
" NeoBundle 'gorodinskiy/vim-coloresque'
" NeoBundle 'tpope/vim-haml'
" NeoBundle 'mattn/emmet-vim'

"" Ruby Bundle
" NeoBundle 'vim-ruby/vim-ruby'
" NeoBundle 'tpope/vim-rails'
" NeoBundle 'tpope/vim-rake'
" NeoBundle 'tpope/vim-projectionist'
" NeoBundle 'thoughtbot/vim-rspec'
" NeoBundle 'ecomba/vim-ruby-refactoring'

"" Lua Bundle
" NeoBundle 'xolox/vim-lua-ftplugin'
" NeoBundle 'xolox/vim-lua-inspect'

"" Crystal Bundle
NeoBundle 'rhysd/vim-crystal'

"" OpsCode Chef Bundle
" NeoBundle 't9md/vim-chef'

"" Markdown Bundle
NeoBundle 'rcmdnk/vim-markdown'

"" HashiCorp Bundle
" NeoBundle 'markcornick/vim-terraform'

"" Docker/Kubernetes Bundle
" NeoBundle 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

" Required:
call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


""""""""""
" Global
" let mapleader="\"
set go=

" Required:
set nocompatible
syntax on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" set hidden
set showcmd
set wrap
set backspace=indent,eol,start
set autoindent
" set copyindent
set number
set cursorline
set shiftround
set ignorecase
set smartcase
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells
" set list
" set listchars=tab:>.,trail:.,extends:#,nbsp:.
set ttyfast
set mouse=a
set nocompatible
set noswapfile
set fileformats=unix,dos,mac
set laststatus=2
" set expandtab
set softtabstop=2 tabstop=2 shiftwidth=2
set ruler
set wildignore=*.swp,*.bak,.DS_Store
set wildmode=longest,list
set shell=/bin/zsh


""""""""""
" neocomplete
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop
let g:acp_enableAtStartup = 0
" Use neocomplete
let g:neocomplete#enable_at_startup = 1
" Use smartcase
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings
" <CR>: close popup and save indent
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return neocomplete#close_popup() . "\<CR>"
	" For no inserting <CR> key
	" return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()
" Close popup by <Space>
" inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
" inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
" inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
" inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
" inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
" let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
" let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
" let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
" set completeopt+=longest
" let g:neocomplete#enable_auto_select = 1
" let g:neocomplete#disable_auto_complete = 1
" inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

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
" let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" neosnippet
let g:neosnippet#enable_snipmate_compatibility = 1
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif


""""""""""
" vimshell
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt = '$ '
nnoremap <F12> :VimShell<CR>
nnoremap <leader><F12> :VimShellBufferDir<CR>


""""""""""
" checkspell
map <F5> :set spell spelllang=en_gb<CR>
" ]s - forward to misspelled/rare/wrong cap word
" [s - backwards ]
" S  - only stop at misspellings
" [S - in other direction
" zG - accept spelling for this session
" zg - accept spelling and add to personal dictionary
" zW - treat as misspelling for this session
" zw - treat as misspelling and add to personal dictionary
" z= - show spelling suggestions
" :spellr - repeat last spell replacement for all words in window


""""""""""
" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" go lint
" install golint: go get -u github.com/golang/lint/golint
set rtp+=~/.golang/src/github.com/golang/lint/misc/vim
augroup FileType go
  au!
  au FileType go nmap gd <Plug>(go-def)
  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)

  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)

  au FileType go nmap <Leader>gi <Plug>(go-info)

  au FileType go nmap <leader>gr <Plug>(go-run)
  au FileType go nmap <leader>rb <Plug>(go-build)
  au FileType go nmap <leader>gt <Plug>(go-test)
augroup END

augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END


""""""""""
"" ruby
" rspec.vim mappings
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>
" ruby refactory
nnoremap <leader>rap  :RAddParameter<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>relv :RExtractLocalVariable<cr>
nnoremap <leader>rit  :RInlineTemp<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>


""""""""""
"" crystal


""""""""""
"" markdown
let g:vim_markdown_folding_disabled=1


""""""""""
"" javascript
let g:javascript_enable_domhtmlcss = 1


""""""""""
"" syntastic
let g:syntastic_auto_loc_list = 1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


""""""""""
"" tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '~/.homebrew/bin/ctags'
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }


""""""""""
"" NERDTree
nnoremap <F11> :NERDTreeToggle<CR>
noremap <leader><F11> :NERDTreeFind<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let NERDTreeWinSize = 35

" let NERDTreeChDirMode = 2
" let NERDTreeAutoCenter = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1 " toggle with I

" Open NERDTree on startup, when no file has been specified
autocmd VimEnter * if !argc() | NERDTree | endif

" NERDTree wide ignore files
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', '\.o$', '\.php\~$']
" Vim wide ignore files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,.DS_Store


""""""""""
"" vim-tmux-navigator
" <ctrl-h> Left
" <ctrl-j> Down
" <ctrl-k> Up
" <ctrl-l> Right
" <ctrl-\> Previous split


""""""""""
"" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = '<U+E0B0>'
  let g:airline#extensions#tabline#left_alt_sep = '<U+E0B1>'

  " powerline symbols
  let g:airline_left_sep = '<U+E0B0>'
  let g:airline_left_alt_sep = '<U+E0B1>'
  let g:airline_right_sep = '<U+E0B2>'
  let g:airline_right_alt_sep = '<U+E0B3>'
  let g:airline_symbols.branch = '<U+E0A0>'
  let g:airline_symbols.readonly = '<U+E0A2>'
  let g:airline_symbols.linenr = '<U+E0A1>'
endif


""""""""""
"" vim-lastplace
let g:lastplace_ignore = "gitcommit,svn"


""""""""""
"" vim-ctrlp
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 0
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>r :CtrlPMRU<CR>
let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'


""""""""""
"" Integration with Clipper https://github.com/wincent/clipper
let s:screen = &term =~ 'screen'
let s:tmux = exists('$TMUX')
let s:xterm = &term =~ 'xterm'
" nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>
set clipboard=unnamed
" make use of Xterm "bracketed paste mode"
" http://www.xfree86.org/current/ctlseqs.html#Bracketed%20Paste%20Mode
" http://stackoverflow.com/questions/5585129
if s:screen || s:xterm
  function! s:BeginXTermPaste(ret)
    set paste
    return a:ret
  endfunction

  " enable bracketed paste mode on entering Vim
  let &t_ti .= "\e[?2004h"

  " disable bracketed paste mode on leaving Vim
  let &t_te = "\e[?2004l" . &t_te

  set pastetoggle=<Esc>[201~
  inoremap <expr> <Esc>[200~ <SID>BeginXTermPaste("")
  nnoremap <expr> <Esc>[200~ <SID>BeginXTermPaste("i")
  vnoremap <expr> <Esc>[200~ <SID>BeginXTermPaste("c")
  cnoremap <Esc>[200~ <nop>
  cnoremap <Esc>[201~ <nop>
endif


""""""""""
" Cycle all vim-colorschemes plugin schemes for 5 sec
" execute :call SchemesCycle()
function! SchemesCycle()
   let currDir = getcwd()
   exec "cd ~/.vim/bundle/vim-colorschemes/colors"
   for myCol in split(glob("*"), '\n')
      if myCol =~ '\.vim'
         let mycol = substitute(myCol, '\.vim', '', '')
         exec "colorscheme " . mycol
         exec "redraw!"
         echo "colorscheme = ". myCol
         sleep 5
      endif
   endfor
   exec "cd " . currDir
endfunction


""""""""""
" Default scheme
colorscheme carvedwoodcool


""""""""""
"" GUI
if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
		colorscheme carvedwoodcool
		set guifont=Menlo\ Regular:h12
  endif

  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
endif


""""""""""
"" Status bar
if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif
" set statusline+=%#warningmsg#
" enable only after full installation
if exists('g:syntastic#SyntasticStatuslineFlag')
	set statusline+=%{SyntasticStatuslineFlag()}
endif


""""""""""
" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall


""""""""""
" Copy/Paste
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>


""""""""""
" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>
" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>


""""""""""
" Buffer nav
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>
" Close buffer
noremap <leader>c :bd<CR>


""""""""""
" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>


""""""""""
" Tabs
nnoremap <silent> <S-t> :tabnew<CR>


""""""""""
" Split window
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>
" to close all windows but the current one use <C-w>o


""""""""""
" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv


""""""""""
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


""""""""""
" Git
noremap <Leader>gma :Gwrite<CR>
noremap <Leader>gmv :Gcommit<CR>
noremap <Leader>gpu :Gpush<CR>
noremap <Leader>gpl :Gpull<CR>
noremap <Leader>gst :Gstatus<CR>
noremap <Leader>gdf :Gvdiff<CR>
