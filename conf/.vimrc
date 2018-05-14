if 0 | endif

if has('vim_starting')
	set nocompatible
	syntax on
	filetype off
	filetype indent on
	filetype plugin on
endif

if has('nvim')
	let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
else
	let vimplug_exists=expand('~/.vim/autoload/plug.vim')
endif

function! InstallPlug(plugpath)
	if !filereadable(a:plugpath)
		echo "Installing vim-plug..."
		execute "!curl -fL --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o " . a:plugpath
" 	silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 	let g:not_finish_vimplug = "yes"
		autocmd VimEnter * PlugInstall
	endif
endfunction

" PlugInstall [name ...] [#threads] - Install plugins
" PlugUpdate [name ...] [#threads] - Install or update plugins
" PlugClean[!] - Remove unused directories (bang version will clean without prompt)
" PlugUpgrade	- Upgrade vim-plug itself
" PlugStatus - Check the status of plugins
" PlugDiff - Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path] - Generate script for restoring the current snapshot of the plugins
call InstallPlug(vimplug_exists)


let g:vim_bootstrap_langs = "go,html,javascript,php,python,ruby"
let g:vim_bootstrap_editor = "nvim"


"" Install vim-plug if required
"" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
	Plug 'flazz/vim-colorschemes'
	Plug 'bling/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	"" Autocomplition and debug
	if has('nvim')
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/deoplete.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif
	let g:deoplete#enable_at_startup = 1

	"" Plugins
	"" Go Bundle
	Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}}
	Plug 'jodosha/vim-godebug'
	Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
	Plug 'godoctor/godoctor.vim'

	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'thaerkh/vim-workspace'
"	Plug 'majutsushi/tagbar'

 " Git Bundle
	Plug 'tpope/vim-fugitive'
	Plug 'mhinz/vim-signify'

	"" C/C++ Bundle
	"Plug 'vim-scripts/c.vim'

	"" Swift Bundle
	"Plug 'keith/swift'

	"" Lua Bundle
	"Plug 'tbastos/vim-lua'

	"" Crystal Bundle
	"Plug 'rhysd/vim-crystal'

	"" OpsCode Chef Bundle
	" Plug 't9md/vim-chef'

	"" HashiVim
	"Plug 'hashivim/vim-consul'
	"Plug 'hashivim/vim-nomadproject'
	"Plug 'hashivim/vim-ottoproject'
	"Plug 'hashivim/vim-packer'
	"Plug 'hashivim/vim-terraform'
	"Plug 'hashivim/vim-vagrant'
	"Plug 'hashivim/vim-vaultproject'

	" Docker/Kubernetes Bundle
	"Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

	" Nginx Bundle
	"Plug 'LeonB/vim-nginx'

	"" Enable clipboard over network connection. https://github.com/wincent/clipper is required
	"Plug 'wincent/vim-clipper'
call plug#end()


"" Global settings override
"let mapleader="\"
set go=

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set hidden
set showtabline=2
set showcmd
set wrap
set backspace=indent,eol,start
set autoindent
"set copyindent
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
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
set ttyfast
set mouse=a
set nocompatible
set noswapfile
set fileformats=unix,dos,mac
set laststatus=2
"set expandtab
set softtabstop=2 tabstop=2 shiftwidth=2
set ruler
set wildignore=*.swp,*.bak,.DS_Store
set wildmode=longest,list
set shell=/bin/zsh
set autowrite

syntax on

set wildmenu
set wildmode=list:longest,full

"" vim-go
"" install metalinter: go get -u github.com/alecthomas/gometalinter
"" Install all known linters: gometalinter --install --update
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
augroup FileType go
	au!
	au FileType go nmap gd <Plug>(go-def)
	au FileType go nmap <Leader>dd <Plug>(go-def-vertical)

	au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
	au FileType go nmap <Leader>db <Plug>(go-doc-browser)

	au FileType go nmap <Leader>gi <Plug>(go-info)

	au FileType go nmap <leader>r <Plug>(go-run)
	au FileType go nmap <leader>b <Plug>(go-build)
	au FileType go nmap <leader>t <Plug>(go-test)

	au FileType go nmap <leader>ml <Plug>(go-metalinter)
	let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
	let go_metalinter_autosave = 1
	let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
	let g:go_metalinter_deadline = "5s"

	map <C-n> :cn<CR>
	map <C-m> :cp<CR>
	nnoremap <leader>a :cclose<CR>

	let g:go_snippet_case_type = "camelcase"

	let g:go_highlight_types = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_structs = 1
	let g:go_highlight_functions = 1
	let g:go_highlight_methods = 1
	" let g:go_highlight_operators = 1
	" let g:go_highlight_extra_types = 1
	let g:go_highlight_build_constraints = 1
augroup END

augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

"" ruby
augroup FileType ruby
	map <leader>t :call RunCurrentSpecFile()<CR>
	map <leader>s :call RunNearestSpec()<CR>
	map <leader>l :call RunLastSpec()<CR>
	map <leader>a :call RunAllSpecs()<CR>
	" ruby refactory
	nnoremap <leader>rap :RAddParameter<CR>
	nnoremap <leader>rcpc :RConvertPostConditional<CR>
	nnoremap <leader>rel :RExtractLet<CR>
	vnoremap <leader>rec :RExtractConstant<CR>
	vnoremap <leader>relv :RExtractLocalVariable<CR>
	nnoremap <leader>rit :RInlineTemp<CR>
	vnoremap <leader>rrlv :RRenameLocalVariable<CR>
	vnoremap <leader>rriv :RRenameInstanceVariable<CR>
	vnoremap <leader>rem :RExtractMethod<CR>
augroup END


""""""""""
"" tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '~/.homebrew/bin/ctags'
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds' : [
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
	\ 'ctagsbin' : 'gotags',
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
"" vim-tmux-navigator
"<ctrl-h> Left
"<ctrl-j> Down
"<ctrl-k> Up
"<ctrl-l> Right
"<ctrl-\> Previous split


""""""""""
"" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


""""""""""
"" vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>
let g:workspace_session_name = '.session.vim'
let g:workspace_session_disable_on_args = 1
let g:workspace_persist_undo_history = 1
let g:workspace_undodir='.undodir'
let g:workspace_autosave_always = 1
let g:workspace_autosave_untrailspaces = 0


""""""""""
"" vim-ctrlp
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_use_caching = 0
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>r :CtrlPMRU<CR>
let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_show_hidden = 1

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" -g ""'


""""""""""
"" vim-fzf
command! -bang -nargs=* Ag call fzf#vim#grep('ag -i --color --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" '.shellescape(<q-args>), 1, <bang>0)

"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)


""""""""""
"" tpope/vim-fugitive
" https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt
noremap <leader>gad :Gwrite<CR> "Write to the current file's path and stage the results. When run in a work tree file, it is effectively git add. Elsewhere, it is effectively git-checkout. A great deal of effort is expended to behave sensibly when the work tree or index version of the file is open in another buffer.

noremap <leader>gpu :Gpush<CR>
noremap <leader>gpl :Gpull<CR>

noremap <leader>gdf :Gvdiff<CR>
noremap <leader>ggr :Ggrep<CR>

noremap <leader>gst :Gstatus<CR> "Press - to add/reset a file's changes, or p to add/reset --patch.
noremap <leader>gco :Gcommit<CR>

noremap <leader>gbl :Gblame<CR>

noremap <leader>gmv :Gmove<CR>
noremap <leader>grm :Gdelete<CR>


""""""""""
"" Theme
set t_Co=256

colorscheme onedark
set background=dark
silent do ColorScheme
" alduin, onedark, sierra
let g:airline_theme='onedark'


""""""""""
"" Abbreviations
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

"" Copy/Paste
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"" Buffer nav
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>
" Close buffer
noremap <leader>c :bd<CR>
" Switch to last-active buffer
nnoremap <leader><leader> <C-^>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
