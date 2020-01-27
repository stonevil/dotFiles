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
		if !executable("curl")
			echoerr "You have to install curl or first install vim-plug yourself!"
			execute "q!"
		endif
		echo 'Installing vim-plug...'
		execute '!curl -fL --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o ' . a:plugpath
		"silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
		"let g:not_finish_vimplug = "yes"
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
	"	Plug 'edkolev/tmuxline.vim'

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
	" Still not decided between FZF and Clap.
	" CLap works faster and using popup window.
	" But not very stable and search pretty limited

	" FZF
	Plug '~/.homebrew/opt/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'pbogut/fzf-mru.vim'
	" Clap. Generic interactive finder and dispatcher
	Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

	" TMUX integration
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tmux-plugins/vim-tmux-focus-events'
	Plug 'roxma/vim-tmux-clipboard'
	"Plug 'blueyed/vim-diminactive'

	" Workspaces support
	Plug 'thaerkh/vim-workspace'

	" Floating terminal
	Plug 'voldikss/vim-floaterm'

	" Undo tree
	Plug 'simnalamburt/vim-mundo'

	"Plug 'scrooloose/nerdtree'
	"Plug 'Xuyuanp/nerdtree-git-plugin'
	"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

	Plug 'ryanoasis/vim-devicons'

	" Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration
	"Plug 'dense-analysis/ale'
	Plug 'desmap/ale-sensible' | Plug 'dense-analysis/ale'

	" Viewer & Finder for LSP symbols and tags
	Plug 'liuchengxu/vista.vim'

	" Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment out the target of a motion
	Plug 'scrooloose/nerdcommenter'

	" Displaying thin vertical lines at each indentation level for code indented with spaces
	Plug 'Yggdroot/indentLine'

	" Vim sugar for the UNIX shell commands
	Plug 'tpope/vim-eunuch'
	":Delete: Delete a buffer and the file on disk simultaneously.
	":Unlink: Like :Delete, but keeps the now empty buffer.
	":Move: Rename a buffer and the file on disk simultaneously.
	":Rename: Like :Move, but relative to the current file's containing directory.
	":Chmod: Change the permissions of the current file.
	":Mkdir: Create a directory, defaulting to the parent of the current file.
	":Cfind: Run find and load the results into the quickfix list.
	":Clocate: Run locate and load the results into the quickfix list.
	":Lfind/:Llocate: Like above, but use the location list.
	":Wall: Write every open window. Handy for kicking off tools like guard.
	":SudoWrite: Write a privileged file with sudo.
	":SudoEdit: Edit a privileged file with sudo.

	"Plug 'junegunn/vim-easy-align'

	" Tabulation
	"Plug 'godlygeek/tabular'

	" Simplifies the transition between multiline and single-line cod
	Plug 'AndrewRadev/splitjoin.vim'
	" gS to split a one-liner into multiple lines
	" gJ (with the cursor on the first line of a block) to join a block into a single-line statement.

	" Provides insert mode auto-completion for quotes, parens, brackets
	Plug 'Raimondi/delimitMate'

	" Snippets
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	" Enable repeating supported plugin maps with "."
	Plug 'tpope/vim-repeat'

	" EnhancedDiff
	"Plug 'chrisbra/vim-diff-enhanced'

	" Go Bundle
	Plug 'zchee/deoplete-go',             { 'build': {'unix': 'make'}, 'for': 'golang' }
	Plug 'fatih/vim-go',                  { 'do': ':GoInstallBinaries', 'for': 'golang' }
	Plug 'godoctor/godoctor.vim',         { 'for': 'golang' }

	" Git Bundle
	Plug 'tpope/vim-fugitive'
	"Plug 'mhinz/vim-signify'
	Plug 'airblade/vim-gitgutter'

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
	"Plug 'fatih/vim-hclfmt'

	" Helm
	"Plug 'towolf/vim-helm'
	"Plug 'mustache/vim-mustache-handlebars'

	" Nginx Bundle
	"Plug 'LeonB/vim-nginx',               { 'for' : 'nginx' }

	" Logstash Bundle
	Plug 'robbles/logstash.vim'

	" TOML Bundle
	"Plug 'cespare/vim-toml'

	" Docker Bundle
	"Plug 'ekalinin/Dockerfile.vim',       { 'for' : 'Dockerfile' }

	" HashiCorp Bundle
	Plug 'hashivim/vim-hashicorp-tools'

	" Ansible Bundle. Snippets do not working: https://github.com/pearofducks/ansible-vim/issues/87
	"Plug 'pearofducks/ansible-vim',       { 'do': './UltiSnips/generate.sh' }

	" JSON Bundle
	"Plug 'elzr/vim-json',                 { 'for' : 'json' }

	" Markdown Bundle
	"Plug 'plasticboy/vim-markdown'

	" Logrotate Bundle
	Plug 'moon-musick/vim-logrotate'

	" Arduino Bundle
	"Plug 'sudar/vim-arduino-syntax',      { 'for': 'arduino' }

	" Polyglot
	Plug 'sheerun/vim-polyglot'

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

set wildignore+=*.bak,.hg,*.swp,__pycache__
set wildignore+=*/tmp/*,*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf
set wildignore+=*.wav,*.mp4,*.mp3
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
set wildignore+=_pycache_,.DS_Store,.vscode,.localized
set wildignore+=.cache,node_modules,package-lock.json,yarn.lock,dist,.git

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

	au FileType go nmap <leader><F9> :GoCoverageToggle -short<CR>
	au FileType go nmap <leader><F10> :GoTest -short<CR>
	au FileType go nmap <leader><F11> <Plug>(go-def)

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

augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

augroup sshconfig
	au!
	au BufRead,BufNewFile  *.sshconfig set syntax=sshconfig
augroup END

augroup shellfile
	au!
	au FileType sh nnoremap <leader><F12> :terminal shellcheck %<CR>
augroup END

augroup vagrantfile
	au!
	au BufRead,BufNewFile Vagrantfile set filetype=ruby
	au FileType ruby nnoremap <leader><F9> :terminal vagrant up<CR>
	au FileType ruby nnoremap <leader><F12> :terminal vagrant validate<CR>
augroup END

augroup dockerfile
	au!
	au FileType Dockerfile nnoremap <leader><F9> :terminal CONTAINERNAME=`basename $PWD \| tr '[:upper:]' '[:lower:]'`; docker build -t $CONTAINERNAME -f % .<CR><CR>
	au FileType Dockerfile nnoremap <leader><F12> :terminal hadolint %<CR>
augroup END

augroup arduinofile
	au!
	au BufRead,BufNewFile *.ino,*.pde,*ide set filetype=c++
	setl statusline=%!ArduinoStatusLine()
augroup END

augroup helmfile
	au!
	au FileType helm nnoremap <leader><F12> :terminal helm install --dry-run --debug .<CR><CR>
augroup END

augroup k8sfile
	au!
	au BufRead,BufNewFile */.kube/config set filetype=yaml
	au BufRead,BufNewFile */templates/*.yaml,*/deployment/*.yaml,*/templates/*.tpl,*/deployment/*.tpl set filetype=yaml.gotexttmpl
	au FileType yaml nnoremap <leader><F12> :terminal kubectl --dry-run -o yam %<CR>
augroup END

augroup markdownfile
	au!
	au BufRead,BufNewFile *.markdown,*.mdown,*.mkdn,*.mkd,*.md,*.mdwn set filetype=markdown
augroup END

augroup ansiblefile
	au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
	au FileType yaml.ansible nnoremap <leader><F12> :terminal ansible-lint .<CR>
augroup END


""""""""""
"" liuchengxu/vim-clap
nnoremap <F4> :Clap files --hidden<CR>
nnoremap <leader><F4> :Clap <CR>


""""""""""
"" ansible-vim
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = 'ob'
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }

"" Yggdroot/indentLine
"let g:indentLine_setColors = 0
":IndentLinesToggle


""""""""""
"" airblade/vim-gitgutter

" jump to next hunk (change): ]c
" jump to previous hunk (change): [c
" stage the hunk with <Leader>hs
" undo it with <Leader>hu
"
" To stage part of any hunk:
" preview the hunk, e.g. <Leader>hp
" move to the preview window, e.g. :wincmd P
" delete the lines you do not want to stage;
" stage the remaining lines: either write (:w) the window or stage via <Leader>hs or :GitGutterStageHunk
"
" ic operates on all lines in the current hunk.
" ac operates on all lines in the current hunk and any trailing empty lines.


""""""""""
"" vista
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1

" Toggle vista view window
nnoremap <silent> <F1> :Vista!!<CR>


""""""""""
"" vim-floaterm
let g:floaterm_keymap_new = '<F9>'
let g:floaterm_keymap_prev = '<F10>'
let g:floaterm_keymap_next = '<F11>'
let g:floaterm_keymap_toggle = '<F12>'

let g:floaterm_width = 0.8
let g:floaterm_height = 0.8


""""""""""
"" vim-diminactive
"let g:diminactive_enable_focus = 1
"let g:diminactive_use_colorcolumn = 1
"let g:diminactive_use_syntax = 1


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
"let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#branch#enabled = 1

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_powerline_separators = 0
"let airline#extensions#tmuxline#snapshot_file = '~/.tmux.theme'


""""""""""
"" vim-workspace
nnoremap <leader>ws :ToggleWorkspace<CR>
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
"" nerdtree
"noremap <F10> :NERDTreeToggle<cr>
"noremap <leader><F10> :NERDTreeFind<cr>
"let NERDTreeShowHidden=1


""""""""""
"" nerdcommenter
"let g:NERDCompactSexyComs = 1
"let g:NERDCommentEmptyLines = 1
"let g:NERDTrimTrailingWhitespace = 1
"let g:NERDToggleCheckAllLines = 1

" Comment out the current line or text selected in visual mode
" [count]<leader>cc
" Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa
" [count]<leader>c<space>
" Adds comment delimiters to the end of line and goes into insert mode between them
" <leader>cA
" Uncomments the selected line(s)
" [count]<leader>cu


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
"" dense-analysis/ale
" Recommended for macOS
let g:delve_backend = "native"
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']
let g:ale_ansible_ansible_lint_executable = 'ansible-lint -x ANSIBLE0204'
let g:ale_set_signs = 0
let g:delve_enable_syntax_highlighting = 1
let g:delve_new_command = "new"

" Hover window support
let g:ale_set_balloons = 1

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_fixers = { '*': ['trim_whitespace', 'remove_trailing_lines'], 'javascript': ['prettier', 'eslint'], 'css' : ['prettier'], 'html' : ['prettier'], 'markdown' : ['prettier'], 'json': ['prettier'], 'sh': ['shfmt'], 'yaml': ['prettier'], 'c' : ['clang-format'], 'cpp' : ['clang-format'], 'python' : ['black'], 'go': ['goimports', 'gofmt'] }

let g:ale_fix_on_save = 1
"let g:ale_lint_on_text_changed = 'never'

nmap <silent> <leader> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <leader> <C-k> <Plug>(ale_next_wrap)


""""""""""
"" vim-mundo
nnoremap <silent> <leader>mt :MundoToggle<CR>
let g:mundo_close_on_revert = 1


""""""""""
"" vim-fzf
" Files (similar to :FZF)
nnoremap <silent> <leader>e :Files<CR>

" Git files (git ls-files)
nnoremap <silent> <leader>g :GFiles<CR>
" Git files (git status)
nnoremap <silent> <leader>g :GFiles?<CR>

" Search Git commits (requires fugitive.vim)
nnoremap <silent> <leader>c  :Commits<CR>
" Search Git commits for the current buffer
nnoremap <silent> <leader>bc :BCommits<CR>

" Search open buffers
nnoremap <silent> <leader>b :Buffers<CR>

" Similar to MRU
nnoremap <silent> <leader>r :FZFMru<CR>

" Search v:oldfiles and open buffers
nnoremap <silent> <leader>h :History<CR>

" Search in windows
nnoremap <silent> <leader>win :Windows<CR>

" Search in command history
nnoremap <silent> <leader>H :History:<CR>

" Search in commands
nnoremap <silent> <leader>com :Commands<CR>

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

nnoremap <silent> <leader>s :Snippets<CR>


""""""""""
"" fzf
" floating fzf window with borders
function! CreateCenteredFloatingWindow()
	let width = min([&columns - 4, max([80, &columns - 20])])
	let height = min([&lines - 4, max([20, &lines - 10])])
	let top = ((&lines - height) / 2) - 1
	let left = (&columns - width) / 2
	let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
	let top = "╭" . repeat("─", width - 2) . "╮"
	let mid = "│" . repeat(" ", width - 2) . "│"
	let bot = "╰" . repeat("─", width - 2) . "╯"
	let lines = [top] + repeat([mid], height - 2) + [bot]
	let s:buf = nvim_create_buf(v:false, v:true)
	call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
	call nvim_open_win(s:buf, v:true, opts)
	set winhl=Normal:Floating
	let opts.row += 1
	let opts.height -= 2
	let opts.col += 2
	let opts.width -= 4
	call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
	au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" Files + devicons + floating fzf
function! Fzf_dev()
	let l:fzf_files_options = '--preview "bat --theme="TwoDark" --style=numbers,changes --color=always {2..-1} | head -'.&lines.'"'
	function! s:files()
		let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
		return s:prepend_icon(l:files)
	endfunction

	function! s:prepend_icon(candidates)
		let l:result = []
		for l:candidate in a:candidates
			let l:filename = fnamemodify(l:candidate, ':p:t')
			let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
			call add(l:result, printf('%s %s', l:icon, l:candidate))
		endfor
		return l:result
	endfunction

	function! s:edit_file(item)
		let l:pos = stridx(a:item, ' ')
		let l:file_path = a:item[pos+1:-1]
		execute 'silent e' l:file_path
	endfunction

	call fzf#run({ \ 'source': <sid>files(), \ 'sink': function('s:edit_file'), \ 'options': '-m --reverse ' . l:fzf_files_options, \ 'down': '40%', \ 'window': 'call CreateCenteredFloatingWindow()'})
endfunction

let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit', 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

"let g:fzf_layout = { 'up': '~60%' }
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" Command for git grep
if executable('git')
	command! -bang -nargs=* GGrep call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
endif

" Command for string search
if executable('rg')
	command! -bang -nargs=* Find call fzf#vim#grep('rg --no-ignore --hidden --follow --ignore-case --column --no-heading --line-number --color=always --glob "!.git/*" --glob "!.svn/*" --glob "!node_modules/*" --glob "!.undodir/*" --glob "!.session.vim" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
endif

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

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(yellow)%h%C(red)%d%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'


""""""""""
"" tpope/vim-fugitive
" https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt
noremap <leader>gad :Gwrite<CR> "Write to the current file's path and stage the results. When run in a work tree file, it is effectively git add. Elsewhere, it is effectively git-checkout. A great deal of effort is expended to behave sensibly when the work tree or index version of the file is open in another buffer.

noremap <leader>gpu :Gpush<CR>
noremap <leader>gpl :Gpull<CR>

noremap <leader>gdf :Gvdiff<CR>
noremap <leader>ggr :Ggrep<CR>

noremap <leader>gst :Gstatus<CR> "Press - to add/reset a file's changes, or p to add/reset --patch.
noremap <leader>gad :Gwrite<CR>
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
"" Enter |Terminal-mode| automatically
autocmd TermOpen * startinsert


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
set colorcolumn=0
set background=dark
silent do ColorScheme
" alduin, kuroi, onehalfdark
"let g:airline_theme='alduin'

highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight Comment ctermbg=NONE guibg=NONE
"highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorColumn ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE

""""""""""
"" Reopen last position
if has('autocmd')
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
