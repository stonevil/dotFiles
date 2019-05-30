" vint: -ProhibitAutocmdWithNoGroup
" vint: -ProhibitSetNoCompatible


if 0 | endif

if has('nvim')
	let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
else
	let vimplug_exists=expand('~/.vim/autoload/plug.vim')
endif

function! InstallPlug(plugpath)
	if !filereadable(a:plugpath)
		echo 'Installing vim-plug...'
		execute '!curl -fL --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o ' . a:plugpath
" 	silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 	let g:not_finish_vimplug = "yes"
		autocmd VimEnter * PlugInstall
	endif
endfunction

" :PlugInstall [name ...] [#threads] - Install plugins
" :PlugUpdate [name ...] [#threads] - Install or update plugins
" :PlugClean[!] - Remove unused directories (bang version will clean without prompt)
" :PlugUpgrade	- Upgrade vim-plug itself
" :PlugStatus - Check the status of plugins
" :PlugDiff - Examine changes from the previous update and the pending changes
" :PlugSnapshot[!] [output path] - Generate script for restoring the current snapshot of the plugins
call InstallPlug(vimplug_exists)


let g:vim_bootstrap_langs = 'go,html,javascript,php,python,ruby'
let g:vim_bootstrap_editor = 'nvim'


"" Install vim-plug if required
"" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
	"Plug 'flazz/vim-colorschemes'
	Plug 'sonph/onehalf', {'rtp': 'vim/'}
	Plug 'aonemd/kuroi.vim'
	Plug 'bling/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'edkolev/tmuxline.vim'

	" Autocomplition and debug
	if has('nvim')
		Plug 'Shougo/deoplete.nvim',        { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/deoplete.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif
	let g:deoplete#enable_at_startup = 1

	" UI/UX
	Plug 'junegunn/fzf' ",                  { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'pbogut/fzf-mru.vim'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tmux-plugins/vim-tmux-focus-events'
	Plug 'roxma/vim-tmux-clipboard'
	Plug 'blueyed/vim-diminactive'
	Plug 'thaerkh/vim-workspace'
	Plug 'simnalamburt/vim-mundo'
	Plug 'majutsushi/tagbar',             { 'on': 'TagbarToggle' }
	Plug 'benmills/vimux'

	Plug 'scrooloose/nerdtree'
	"	Plug 'Xuyuanp/nerdtree-git-plugin'

	" Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration
	Plug 'w0rp/ale'

	" Land on window you chose like tmux's 'display-pane'
	Plug 't9md/vim-choosewin'

	" Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment out the target of a motion
	Plug 'tpope/vim-commentary'

	" Displaying thin vertical lines at each indentation level for code indented with spaces
	Plug 'Yggdroot/indentLine'

	" Vim sugar for the UNIX shell commands
	Plug 'tpope/vim-eunuch'
	" :Delete: Delete a buffer and the file on disk simultaneously
	" :Unlink: Like :Delete, but keeps the now empty buffer
	" :Move: Rename a buffer and the file on disk simultaneously
	" :Rename: Like :Move, but relative to the current file's containing directory
	" :Chmod: Change the permissions of the current file
	" :Mkdir: Create a directory, defaulting to the parent of the current file
	" :Find: Run find and load the results into the quickfix list
	" :Locate: Run locate and load the results into the quickfix list
	" :Wall: Write every open window. Handy for kicking off tools like guard
	" :SudoWrite: Write a privileged file with sudo.
	" :SudoEdit: Edit a privileged file with sudo

	" Tabulation
	Plug 'godlygeek/tabular'

	" Simplifies the transition between multiline and single-line cod
	Plug 'AndrewRadev/splitjoin.vim'
	" gS to split a one-liner into multiple lines
	" gJ (with the cursor on the first line of a block) to join a block into a single-line statement.

	" Provides insert mode auto-completion for quotes, parens, brackets
	Plug 'Raimondi/delimitMate'

	" Snippets
	Plug 'SirVer/ultisnips'

	" Go Bundle
	Plug 'zchee/deoplete-go',             { 'build': {'unix': 'make'}, 'for': 'golang' }
	Plug 'jodosha/vim-godebug',           { 'for': 'golang' }
	Plug 'fatih/vim-go',                  { 'do': ':GoInstallBinaries', 'for': 'golang' }
	Plug 'godoctor/godoctor.vim',         { 'for': 'golang' }
	Plug 'benmills/vimux-golang',         { 'for': 'golang' }

	" Git Bundle
	Plug 'tpope/vim-fugitive'
	Plug 'mhinz/vim-signify'

	" C/C++/ObjC Bundle
	"Plug 'vim-scripts/c.vim'
	"Plug 'zchee/deoplete-clang'

	" Swift Bundle
	"Plug 'keith/swift',                  { 'for': 'swift' }
	"Plug 'mitsuse/autocomplete-swift',   { 'for': 'swift' }

	" Lua Bundle
	"Plug 'tbastos/vim-lua'

	" Crystal Bundle
	"Plug 'rhysd/vim-crystal',            { 'for': 'ruby' }
	"Plug 'yoru/deoplete-crystal',        { 'for': 'ruby' }

	" Ruby Bundle
	"Plug 'uplus/deoplete-solargraph',    { 'for': 'ruby' }

	" OpsCode Chef Bundle
	"Plug 't9md/vim-chef'

	" HCL
	Plug 'fatih/vim-hclfmt'

	" Nginx Bundle
	Plug 'LeonB/vim-nginx',               { 'for' : 'nginx' }

	" TOML Bundle
	Plug 'cespare/vim-toml'

	" Docker Bundle
	Plug 'ekalinin/Dockerfile.vim',       { 'for' : 'Dockerfile' }

	" HashiCorp Bundle
	Plug 'hashivim/vim-hashicorp-tools'

	" Ansible Bundle
	Plug 'pearofducks/ansible-vim',       { 'do': 'cd ./UltiSnips; ./generate.py' }

	" JSON Bundle
	Plug 'elzr/vim-json',                 { 'for' : 'json' }

	" Markdown Bundle
	Plug 'plasticboy/vim-markdown'

	" Arduino Bundle
	Plug 'sudar/vim-arduino-syntax',      { 'for': 'arduino' }
	Plug 'stevearc/vim-arduino',          { 'for': 'arduino' }
	" :ArduinoChooseBoard - Select the type of board from a list.
	" :ArduinoChooseProgrammer - Select the programmer from a list.
	" :ArduinoChoosePort - Select the serial port from a list.
	" :ArduinoVerify - Build the sketch.
	" :ArduinoUpload - Build and upload the sketch.
	" :ArduinoSerial - Connect to the board for debugging over a serial port.
	" :ArduinoUploadAndSerial - Build, upload, and connect for debugging.


	" Enable clipboard over network connection. https://github.com/wincent/clipper is required
	"Plug 'wincent/vim-clipper'
call plug#end()


"" Global settings override
"let mapleader="\"
set guioptions=

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

set nocompatible								" Enables us Vim specific features
syntax on												" Enable syntax highlighting
filetype off										" Reset filetype detection first ...
filetype plugin indent on				" ... and enable filetype detection

set ttyfast											" Indicate fast terminal conn for faster redraw
set mouse=a											" Enable proper mouse selection

set history=1000
set undolevels=1000

set shell=/bin/zsh

set encoding=utf-8							" Set default encoding to UTF-8
set fileencoding=utf-8
set fileencodings=utf-8
scriptencoding utf-8

set autoread										" Automatically read changed files
set autowrite										" Automatically save before :next, :make etc.
set noswapfile									" Don't use swapfile
set nobackup										" Don't create annoying backup files
set fileformats=unix,dos,mac		" Prefer Unix over Windows over OS 9 formats
set wildignore+=*.bak,*.o,*.obj,.git,.hg,.svn,*.rbc,*.pyc,__pycache__,*.swp,.DS_Store

set autoindent									" Enabile Autoindent
set shiftround									" Round indent to multiple of 'shiftwidth'. Applies to > and < commands.
set noexpandtab ci pi sts=2 ts=2 sw=2	" noexpandtab, copyindent, preserveindent, softtabstop=2, shiftwidth=2, tabstop=2
set wrap linebreak nolist				" Word wrap without line breaks
set backspace=indent,eol,start	" Makes backspace key more powerful.

set showtabline=2								" Always show tabline
set laststatus=2								" Show status line always

set incsearch										" Shows the match while typing
set hlsearch										" Highlight found searches
set ignorecase									" Search case insensitive...
set smartcase										" ... but not it begins with upper case

set noerrorbells								" No beeps
set visualbell									" At times when a beep would have occurred, the screen will flash instead
set number											" Show line numbers
set showcmd											" Show me what I'm typing
set splitright									" Vertical windows should be split to right
set splitbelow									" Horizontal windows should split to bottom

set hidden											" Buffer should still exist if window is closed
set showmatch										" Show matching brackets by flickering
set noshowmode									" We show the mode with airline or lightline
set completeopt=menu,menuone		" Show popup menu, even if there is one entry
set pumheight=10								" Completion window max size
set nocursorcolumn							" Do not highlight column (speeds up highlighting)
set cursorline									" Highlight current line
set lazyredraw									" Wait to redraw

set confirm											" Confirm changes (Yes, No, Cancel) instead of error

"set wildmenu										" Visual autocomplete for command menu. Done by airline
"set wildmode=list:longest,full

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Toggle line numbering
nnoremap <leader>N :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

"" Functions
" toggle between number and relativenumber
function! ToggleNumber()
	if(&relativenumber == 1)
		set norelativenumber
		set number
	else
		set relativenumber
	endif
endfunc

function! ArduinoStatusLine()
	let port = arduino#GetPort()
	let line = '%f [' . g:arduino_board . '] [' . g:arduino_programmer . ']'
	if !empty(port)
		let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
	endif
	return line
endfunction

" Toggle spell with a language
function! ToggleSpell(lang)
	if !exists('b:old_spelllang')
		let b:old_spelllang = &spelllang
		let b:old_spellfile = &spellfile
		let b:old_dictionary = &dictionary
	endif
	let l:newMode = ''
	if !&l:spell || a:lang != &l:spelllang
		setlocal spell
		let l:newMode = 'spell'
		execute 'setlocal spelllang=' . a:lang
		execute 'setlocal spellfile=' . '~/.vim/spell/' . matchstr(a:lang, '[a-zA-Z][a-zA-Z]') . '.' . &encoding . '.add'
		execute 'setlocal dictionary=' . '~/.vim/spell/' . a:lang . '.' . &encoding . '.dic'
		let l:newMode .= ', ' . a:lang
	else
		setlocal nospell
		let l:newMode = 'nospell'
		execute 'setlocal spelllang=' . b:old_spelllang
		execute 'setlocal spellfile=' . b:old_spellfile
		execute 'setlocal dictionary=' . b:old_dictionary
	endif
	return l:newMode
endfunction
nnoremap <leader>gb :call ToggleSpell("en_gb")<CR> "Toggle English spell
nnoremap <leader>uk :call ToggleSpell("uk_ua")<CR> "Toggle Ukraine spell

"" Vimux global settings
if exists('$TMUX')
	map <leader>vx :VimuxInterruptRunner<CR>
	map <leader><F12> :VimuxRunLastCommand<CR>
	map <leader>vi :VimuxInspectRunner<CR>
	map <leader>vq :VimuxCloseRunner<CR>
	map <leader>vz :call VimuxZoomRunner()<CR>
	map <leader>vp :VimuxPromptCommand<CR>
endif

"" Configuration groups
augroup FileType go
	au!
	set runtimepath+=$GOPATH/src/github.com/golang/lint/misc/vim

	au FileType go nmap <leader>dd <Plug>(go-def-vertical)

	au FileType go nmap <leader>dv <Plug>(go-doc-vertical)
	au FileType go nmap <leader>db <Plug>(go-doc-browser)

	au FileType go nmap <leader>gi <Plug>(go-info)

	au FileType go nmap <leader>r <Plug>(go-run)
	au FileType go nmap <leader>b <Plug>(go-build)
	au FileType go nmap <leader>t <Plug>(go-test)

	au FileType go nmap <F9> :GoCoverageToggle -short<CR>
	au FileType go nmap <F10> :GoTest -short<CR>
	au FileType go nmap <F12> <Plug>(go-def)

	au FileType go nmap <leader><F12> <Plug>(go-metalinter)

	let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
	let go_metalinter_autosave = 1
	let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
	let g:go_metalinter_deadline = '5s'
	let g:go_fmt_command = 'goimports'

	map <C-n> :cn<CR>
	map <C-m> :cp<CR>
	nnoremap <leader>a :cclose<CR>

	let g:go_snippet_case_type = 'camelcase'

	let g:go_addtags_transform = 'snakecase'

	let g:go_highlight_types = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_structs = 1
	let g:go_highlight_functions = 1
	let g:go_highlight_methods = 1
	" let g:go_highlight_operators = 1
	" let g:go_highlight_extra_types = 1
	let g:go_highlight_build_constraints = 1

	let g:go_auto_sameids = 1
	let g:go_auto_type_info = 1
augroup END

augroup sshconfig
	au!
	au BufRead,BufNewFile  *.sshconfig set syntax=sshconfig
augroup END

augroup vagrant
	au!
	au BufRead,BufNewFile Vagrantfile set filetype=ruby
	if exists('$TMUX')
		au FileType ruby nmap <F12> :call VimuxRunCommandInDir("vagrant validate")<CR>
	endif
augroup END

augroup docker
	au!
	au BufRead,BufNewFile Dockerfile set filetype=Dockerfile
	if exists('$TMUX')
		au FileType Dockerfile nmap <F12> :call VimuxRunCommandInDir("CONTAINERNAME=`basename $PWD \| tr '[:upper:]' '[:lower:]'`; docker build -t $CONTAINERNAME .", 0)<CR><CR>
	endif
augroup END

augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

augroup arduino
	au!
	au BufRead,BufNewFile *.ino,*.pde,*ide set filetype=c++
	setl statusline=%!ArduinoStatusLine()
augroup END

augroup kubernetes
	au!
	au BufRead,BufNewFile */.kube/config set filetype=yaml
	au BufRead,BufNewFile */templates/*.yaml,*/deployment/*.yaml,*/templates/*.tpl,*/deployment/*.tpl set filetype=yaml.gotexttmpl
	au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
	if exists('$TMUX')
		au FileType yaml nmap <F7> :call VimuxRunCommand("clear; kubectl apply -f ". bufname("%"))<CR>
		au FileType yaml nmap <F8> :call VimuxRunCommand("clear; kubectl delete -f ". bufname("%"))<CR>
		au FileType yaml nmap <F3> :call VimuxRunCommand("clear; kubectl get -f ". bufname("%"))<CR>
		au FileType yaml nmap <F12> :call VimuxRunCommand("clear; kubeval ". bufname("%"))<CR>
	endif
augroup END

augroup markdown
	au!
	au BufRead,BufNewFile *.markdown,*.mdown,*.mkdn,*.mkd,*.md,*.mdwn set filetype=markdown
augroup END


""""""""""
"" ansible-vim
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = 'ob'
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }

"" Yggdroot/indentLine
"let g:indentLine_setColors = 0
":IndentLinesToggle


""""""""""
"" tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_type_go = { 'ctagstype' : 'go', 'kinds' : [ 'p:package', 'i:imports:1', 'c:constants', 'v:variables', 't:types', 'n:interfaces', 'w:fields', 'e:embedded', 'm:methods', 'r:constructor', 'f:functions' ], 'sro' : '.', 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' }, 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' }, 'ctagsbin' : 'gotags', 'ctagsargs' : '-sort -silent' }
let g:tagbar_type_ruby = { 'kinds' : [ 'm:modules', 'c:classes', 'd:describes', 'C:contexts', 'f:methods', 'F:singleton methods' ] }
let g:tagbar_type_ansible = { 'ctagstype' : 'ansible', 'kinds' : [ 't:tasks' ], 'sort' : 0 }
let g:tagbar_type_puppet = { 'ctagstype': 'puppet', 'kinds': [ 'c:class', 's:site', 'n:node', 'd:definition' ]}
let g:tagbar_type_markdown = { 'ctagstype' : 'markdown', 'kinds' : [ 'h:Heading_L1', 'i:Heading_L2', 'k:Heading_L3' ]}


""""""""""
"" vim-diminactive
let g:diminactive_enable_focus = 1
let g:diminactive_use_colorcolumn = 1
let g:diminactive_use_syntax = 1


""""""""""
"" vim-tmux-navigator
"	<ctrl-h> Left
"	<ctrl-j> Down
"	<ctrl-k> Up
"	<ctrl-l> Right
"	<ctrl-\> Previous split
let g:tmux_navigator_disable_when_zoomed = 1


""""""""""
"" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

let g:airline#extensions#tmuxline#enabled = 1
let g:tmuxline_powerline_separators = 0
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = '~/.tmux.theme'


""""""""""
"" vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>
if empty($VIM_SESSION_FILENAME)
	let g:workspace_session_name = 'Session.vim'
else
	let g:workspace_session_name = $VIM_SESSION_FILENAME
endif
let g:workspace_session_disable_on_args = 1
let g:workspace_persist_undo_history = 1
"let g:workspace_undodir='.undodir'
let g:workspace_autosave_always = 1
let g:workspace_autosave_untrailspaces = 0


""""""""""
"" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"


""""""""""
"" vim-mundo
noremap <F10> :NERDTreeToggle<cr>
noremap <leader><F10> :NERDTreeFind<cr>
let NERDTreeShowHidden=1


""""""""""
"" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['go=go', 'viml=vim', 'bash=sh']
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1


""""""""""
"" vim-json
let g:vim_json_syntax_conceal = 0


""""""""""
"" w0rp/ale
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']
let g:ale_ansible_ansible_lint_executable = 'ansible-lint -x ANSIBLE0204'
let g:ale_set_signs = 0

nmap <silent> <leader> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <leader> <C-k> <Plug>(ale_next_wrap)


""""""""""
"" vim-mundo
nnoremap <F5> :MundoToggle<CR>
let g:mundo_close_on_revert = 1


""""""""""
"" vim-Choosewin
nmap - <Plug>(choosewin)


""""""""""
"" vim-fzf
" Default fzf layout
nnoremap <silent> <leader>e :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>] :Buffers<CR>
nnoremap <silent> <leader>r :FZFMru<CR>
nnoremap <silent> <leader>h :History<CR>

" Search in command history
nnoremap <silent> <leader>H :History:<CR>

" Search for lines in current buffer
nnoremap <silent> <leader>f :BLines<CR>
" Search for lines in loaded buffers
nnoremap <silent> <leader>F :Lines<CR>
" Search for marked lines
nnoremap <silent> <leader>' :Marks<CR>

nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>T :BTags<CR>

nnoremap <silent> <leader>rg :Rg<Space>
nnoremap <silent> <leader>! :Rg!<Space>

nnoremap <silent> <leader>ft :Filetypes<CR>

let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit', 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

let g:fzf_layout = { 'up': '~60%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':				['fg', 'Normal'],
	\ 'bg':				['bg', 'Normal'],
	\ 'hl':				['fg', 'Comment'],
	\ 'fg+':			['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':			['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':			['fg', 'Statement'],
	\ 'info':			['fg', 'PreProc'],
	\ 'border':		['fg', 'Ignore'],
	\ 'prompt':		['fg', 'Conditional'],
	\ 'pointer':	['fg', 'Exception'],
	\ 'marker':		['fg', 'Keyword'],
	\ 'spinner':	['fg', 'Label'],
	\ 'header':		['fg', 'Comment'] }

let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <silent> <leader>c  :Commits<CR>
nnoremap <silent> <leader>bc :BCommits<CR>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(yellow)%h%C(red)%d%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Command for git grep
if executable('git')
	command! -bang -nargs=* GGrep call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
endif

" Command for string search
if executable('rg')
	command! -bang -nargs=* Find call fzf#vim#grep('rg --no-ignore --hidden --follow --ignore-case --column --no-heading --line-number --color=always '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
endif


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
"" godlygeek/tabular
" :Tabularize /^[^=]*\zs=
command! -nargs=1 -range TabFirst exec <line1> . ',' . <line2> . 'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')


""""""""""
"" ultisnips
function! g:UltiSnips_Complete()
	call UltiSnips#ExpandSnippet()
	if g:ulti_expand_res == 0
		if pumvisible()
			return "\<C-n>"
		else
			call UltiSnips#JumpForwards()
			if g:ulti_jump_forwards_res == 0
				return "\<TAB>"
				endif
			endif
	endif
	return ''
endfunction

function! g:UltiSnips_Reverse()
	call UltiSnips#JumpBackwards()
	if g:ulti_jump_backwards_res == 0
		return "\<C-P>"
	endif

	return ''
endfunction

if !exists('g:UltiSnipsJumpForwardTrigger')
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
endif

if !exists('g:UltiSnipsJumpBackwardTrigger')
	let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
endif

au InsertEnter * exec 'inoremap <silent> ' . g:UltiSnipsExpandTrigger . ' <C-R>=g:UltiSnips_Complete()<cr>'
au InsertEnter * exec 'inoremap <silent> ' . g:UltiSnipsJumpBackwardTrigger . ' <C-R>=g:UltiSnips_Reverse()<cr>'


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

set pastetoggle=<F1>

"" Manage splits
" Create a vertical split using :vsp and horizontal with :sp
" Max out the height of the current split
" ctrl+w _
" Max out the width of the current split
" ctrl+w |
" Normalize all split sizes, which is very handy when resizing terminal
" ctrl+w =
" Swap top/bottom or left/right split
" ctrl+w R
" Break out current window into a new tabview
" ctrl+w T
" Close every window in the current tabview but the current one
" ctrl+w o

"" Manage buffers
" Buffer nav
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>
" New buffer
noremap <leader>N :enew<CR>
" Close buffer
noremap <leader>c :bd<CR>
noremap <leader>c! :bd!<CR>
" Switch to last-active buffer
nnoremap <leader><leader> <C-^>

" :bd          - deletes the current buffer, error if there are unwritten changes
" :bd!         - deletes the current buffer, no error if unwritten changes
" :bufdo bd    - deletes all buffers, stops at first error (unwritten changes)
" :bufdo! bd   - deletes all buffers except those with unwritten changes
" :bufdo! bd!  - deletes all buffers, no error on any unwritten changes

" :bw          - completely deletes the current buffer, error if there are unwritten changes
" :bw!         - completely deletes the current buffer, no error if unwritten changes
" :bufdo bw    - completely deletes all buffers, stops at first error (unwritten changes)
" :bufdo! bw   - completely deletes all buffers except those with unwritten changes
" :bufdo! bw!  - completely deletes all buffers, no error on any unwritten changes

" :ls          - list open buffers
" :b N         - open buffer number N (as shown in ls)
" :tabe +Nbuf  - open buffer number N in new tab
" :bnext       - go to the next buffer (:bn also)
" :bprevious   - go to the previous buffer (:bp also)


"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


""""""""""
"" Theme
set t_Co=256
"set termguicolors								" Use the true color mode

colorscheme kuroi
set background=dark
silent do ColorScheme
" alduin, kuroi, onehalfdark
"let g:airline_theme='alduin'

set colorcolumn=0
highlight ColorColumn ctermbg=235 guibg=#2c2d27

""""""""""
"" Reopen last position
if has('autocmd')
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
