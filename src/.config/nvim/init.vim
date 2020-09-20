" vim:ft=vim :
" vint: -ProhibitAutocmdWithNoGroup
" vint: -ProhibitSetNoCompatible


if 0 | endif

if has("gui_vimr")
	:cd $HOME . '/Documents'
endif

if has('nvim')
	let vimplug_exists=expand($HOME . '/.config/nvim/autoload/plug.vim')
else
	let vimplug_exists=expand($HOME . '/.vim/autoload/plug.vim')
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

" :PlugInstall [name ...] [#threads]	- Install plugins
" :PlugUpdate [name ...] [#threads]		- Install or update plugins
" :PlugClean[!]												- Remove unused directories (bang version will clean without prompt)
" :PlugUpgrade												- Upgrade vim-plug itself
" :PlugStatus													- Check the status of plugins
" :PlugDiff														- Examine changes from the previous update and the pending changes
" :PlugSnapshot[!] [output path]			- Generate script for restoring the current snapshot of the plugins

call InstallPlug(vimplug_exists)

"" Install vim-plug if required
"" Required:
call plug#begin(expand($HOME . '/.config/nvim/plugged'))
	Plug 'ayu-theme/ayu-vim'
	Plug 'danilo-augusto/vim-afterglow'

	Plug 'bling/vim-airline'

	" FZF
	Plug $HOME . '/.homebrew/opt/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'dominickng/fzf-session.vim'

	" Ranger integration
	if has('nvim')
		Plug 'kevinhwang91/rnvimr'
	endif

	" TMUX integration
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tmux-plugins/vim-tmux-focus-events'
	Plug 'roxma/vim-tmux-clipboard'
	"Plug 'wellle/tmux-complete.vim'

	" Git Integration
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	" Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment out the target of a motion
	Plug 'scrooloose/nerdcommenter'

	" Displaying thin vertical lines at each indentation level for code indented with spaces
	Plug 'Yggdroot/indentLine'
	"Plug 'thaerkh/vim-indentguides'

	" Better % navigate and highlight matching words modern matchit and matchparen replacement
	"Plug 'andymass/vim-matchup'
	" adds motions g%, [%, ]%, and z%

	" Plug 'kshenoy/vim-signature'
	" mx         - Toggle mark 'x' and display it in the leftmost column
	" dmx        - Remove mark 'x' where x is a-zA-Z

	" m,         - Place the next available mark
	" m.         - If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
	" m-         - Delete all marks from the current line
	" m<Space>   - Delete all marks from the current buffer
	" ]`         - Jump to next mark
	" [`         - Jump to prev mark
	" ]'         - Jump to start of next line containing a mark
	" ['         - Jump to start of prev line containing a mark
	" `]         - Jump by alphabetical order to next mark
	" `[         - Jump by alphabetical order to prev mark
	" ']         - Jump by alphabetical order to start of next line having a mark
	" '[         - Jump by alphabetical order to start of prev line having a mark
	" m/         - Open location list and display marks from current buffer

	" m[0-9]     - Toggle the corresponding marker !@#$%^&*()
	" m<S-[0-9]> - Remove all markers of the same type
	" ]-         - Jump to next line having a marker of the same type
	" [-         - Jump to prev line having a marker of the same type
	" ]=         - Jump to next line having a marker of any type
	" [=         - Jump to prev line having a marker of any type
	" m?         - Open location list and display markers from current buffer
	" m<BS>      - Remove all markers

	" Vim sugar for the UNIX shell commands
	Plug 'tpope/vim-eunuch'
	" :Delete         - Delete a buffer and the file on disk simultaneously.
	" :Unlink         - Like :Delete, but keeps the now empty buffer.
	" :Move           - Rename a buffer and the file on disk simultaneously.
	" :Rename         - Like :Move, but relative to the current file's containing directory.
	" :Chmod          - Change the permissions of the current file.
	" :Mkdir          - Create a directory, defaulting to the parent of the current file.
	" :Cfind          - Run find and load the results into the quickfix list.
	" :Clocate        - Run locate and load the results into the quickfix list.
	" :Lfind/:Llocate - Like above, but use the location list.
	" :Wall           - Write every open window. Handy for kicking off tools like guard.
	" :SudoWrite      - Write a privileged file with sudo.
	" :SudoEdit       - Edit a privileged file with sudo.

	" A Vim alignment plugin
	Plug 'junegunn/vim-easy-align'
	" https://github.com/junegunn/vim-easy-align

	" Provides insert mode auto-completion for quotes, parens, brackets
	"Plug 'Raimondi/delimitMate'
	Plug 'jiangmiao/auto-pairs'
	"Plug 'cohama/lexima.vim'

	" Adds various text objects to give you more targets to operate on
	"Plug 'wellle/targets.vim'

	" Enable repeating supported plugin maps with "."
	Plug 'tpope/vim-repeat'

	" Snippets
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'tenfyzhong/CompleteParameter.vim'

	" Logrotate Bundle
	"Plug 'moon-musick/vim-logrotate', {'for': 'logrotate'}

	" Hugo Bundle
	"Plug 'robertbasic/vim-hugo-helper'

	" Polyglot
	Plug 'sheerun/vim-polyglot'

	" Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration
	Plug 'dense-analysis/ale'

	" Go IDE
	if has('nvim')
		Plug 'fatih/vim-go'
	else
		Plug 'govim/govim'
	endif

	" Intellisense engine for Vim8 & Neovim
	if has('nvim')
		Plug 'ncm2/ncm2'
		Plug 'roxma/nvim-yarp'
	else
		Plug 'ncm2/ncm2'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif
	Plug 'ncm2/ncm2-bufword'
	Plug 'fgrsnau/ncm2-otherbuf'
	Plug 'ncm2/ncm2-path'
	Plug 'ncm2/ncm2-tmux'
	Plug 'ncm2/ncm2-gtags'
	Plug 'ncm2/ncm2-jedi'
	Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
	Plug 'ncm2/ncm2-go'
	Plug 'ncm2/ncm2-ultisnips'
call plug#end()


"" Global settings override
"let mapleader="\"
set guioptions=

" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
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

set shell=/bin/zsh							" Add -i to load profile files. Enables $PATH, etc. Have an issues with some junk line inserted on file save

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
set scrolloff=4									" Keep 4 lines above or below the cursor when scrolling

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
set updatetime=300							" Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c								" Don't give |ins-completion-menu| messages
set signcolumn=yes							" Always show signcolumns
set showmatch										" Show matching brackets by flickering
set noshowmode									" We show the mode with airline or lightline
set completeopt=noinsert,longest,menuone,noselect
set pumheight=10								" Completion window max size
set nocursorcolumn							" Do not highlight column (speeds up highlighting)
set cursorline									" Highlight current line
set lazyredraw									" Wait to redraw

set confirm											" Confirm changes (Yes, No, Cancel) instead of error

"set wildmenu										" Visual autocomplete for command menu. Done by airline
"set wildmode=list:longest,full

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Create new buffer
nnoremap <leader>N :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>


""""""""""
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
		execute 'setlocal spellfile=' . $HOME . '/.local/share/nvim-spell/' . matchstr(a:lang, '[a-zA-Z][a-zA-Z]') . '.' . &encoding . '.add'
		execute 'setlocal dictionary=' . $HOME . '/.local/share/nvim-spell/' . a:lang . '.' . &encoding . '.dic'
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

" Floating window with borders
function! OpenFloatingWindow()
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

" Hunk stage and stage commit
function! HunkStageAndCommit() abort
	:GitGutterStageHunk
	:Gcommit
endfunction
nnoremap <leader>hc :call HunkStageAndCommit()<CR>


""""""""""
"" Configuration groups
augroup FileType go
	autocmd!
	set runtimepath+=$GOPATH/src/github.com/golang/lint/misc/vim
	let g:go_def_mapping_enabled = 0
	let g:go_def_mode='gopls'
	let g:go_info_mode='gopls'

	let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
	let go_metalinter_autosave = 1
	let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
	let g:go_metalinter_deadline = '5s'
	let g:go_fmt_command = 'goimports'

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

augroup dotFiles
	autocmd!
	autocmd BufRead,BufNewFile ~/.Files/* nnoremap <leader><F9> :new +resize20 term://zsh -i -c '_files_dot_install && exit'<CR><CR>
augroup END

augroup tmuxfile
	autocmd!
	autocmd BufRead,BufNewFile .tmux.conf set filetype=tmux
	if exists('$TMUX')
		autocmd FileType tmux nnoremap <leader><F12> :new +resize20 term://zsh -i -c '_files_dot_install && tmux source-file ~/.tmux.conf && exit'<CR>
	endif
augroup END

augroup shellfile
	autocmd!
	autocmd FileType sh nnoremap <leader><F12> :new +resize20 term://zsh -i -c 'shellcheck %'<CR>
augroup END

augroup sshconfig
	autocmd!
	autocmd BufRead,BufNewFile *.sshconfig set syntax=sshconfig
augroup END

augroup vagrantfile
	autocmd!
	autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
	autocmd FileType ruby nnoremap <leader><F9> :new +resize20 term://zsh -i -c 'vagrant up'<CR>
	autocmd FileType ruby nnoremap <leader><F12> :new +resize20 term://zsh -i -c 'vagrant validate'<CR>
augroup END

augroup dockerfile
	autocmd!
	autocmd FileType Dockerfile nnoremap <leader><F9> :new +resize20 term://zsh -i -c "CONTAINERNAME=`basename $PWD \| tr '[:upper:]' '[:lower:]'`; docker build -t $CONTAINERNAME -f % ."<CR><CR>
	autocmd FileType Dockerfile nnoremap <leader><F12> :new +resize20 term://zsh -i -c 'hadolint %'<CR>
augroup END

augroup arduinofile
	autocmd!
	autocmd BufRead,BufNewFile *.ino,*.pde,*ide set filetype=c++
augroup END

augroup helmfile
	autocmd!
	autocmd FileType helm nnoremap <leader><F12> :new +resize20 term://zsh -i -c 'helm install --dry-run --debug .'<CR><CR>
augroup END

augroup k8sfile
	autocmd!
	autocmd BufRead,BufNewFile */.kube/config set filetype=yaml
	autocmd BufRead,BufNewFile */templates/*.yaml,*/deployment/*.yaml,*/templates/*.tpl,*/deployment/*.tpl set filetype=yaml.gotexttmpl
	autocmd FileType yaml nnoremap <leader><F12> :new +resize20 term://zsh -i -c 'kubectl --dry-run -o yam %'<CR>
augroup END

augroup markdownfile
	autocmd!
	autocmd BufRead,BufNewFile *.markdown,*.mdown,*.mkdn,*.mkd,*.md,*.mdwn set filetype=markdown
augroup END

augroup ansiblefile
	autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
	autocmd FileType yaml.ansible nnoremap <leader><F12> :new +resize20 term://zsh -i -c 'ansible-lint .'<CR>
augroup END


""""""""""
"" ansible-vim
let g:ansible_unindent_after_newline = 1
"let g:ansible_attribute_highlight = 'ab'
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }
let g:ansible_extra_keywords_highlight = 1
let g:ansible_name_highlight = 'd'


""""""""""
"" Yggdroot/indentLine
"let g:indentLine_setColors = 0
" :IndentLinesToggle


""""""""""
"" thaerkh/vim-indentguides
let g:indentguides_firstlevel = 1
let g:indentguides_ignorelist = ['text', 'rmd', 'markdown', 'tex', 'rmarkdown', 'pandoc', 'nerdtree']
let g:indentguides_spacechar = '¦'
let g:indentguides_tabchar = '¦'
"let g:indentguides_conceal_color = 'ctermfg=238 ctermbg=234 guifg=#4e4e4e guibg=NONE'


""""""""""
"" junegunn/fzf.vim
" Search files
nnoremap <silent> <leader>e :Files<CR>
nnoremap <silent> <leader>ee :History<CR>

" Search in git files
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>gf :GFiles?<CR>

" Search in git commits
nnoremap <silent> <leader>bc :BCommits<CR>
nnoremap <silent> <leader>gc :Commits<CR>

" Search buffers
nnoremap <silent> <leader><leader> :Buffers<CR>

" Search windows
nnoremap <silent> <leader><leader><leader> :Windows<CR>

" Search mapps
nnoremap <silent> <leader>mm :Maps<CR>

" Search for marked lines
nnoremap <silent> <leader>` :Marks<CR>

" Search for ctags
nnoremap <silent> <leader>`` :BTags<CR>
nnoremap <silent> <leader>``` :Tags<CR>

" Search for lines in buffers
nnoremap <silent> <leader>f :BLines<CR>
nnoremap <silent> <leader>ff :Lines<CR>

" Search command and command history
nnoremap <silent> <leader>co :Commands<CR>
nnoremap <silent> <leader>ch :History:<CR>

" Search in search history
nnoremap <silent> <leader>sh :History/<CR>

" Search in snippets
nnoremap <silent> <leader>ss :Snippets<CR>

" Search in filetypes
nnoremap <silent> <leader>ft ::Filetypes<CR>

" Search with Ag
nnoremap <silent> <leader>ag :Ag<CR>

" Search with Rg
nnoremap <silent> <leader>rg :Rg<CR>

"" fzf layout: - down / up / left / right
"let g:fzf_layout = { 'down': '80%' }
"" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'down:50%'

" fzf layout
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8, 'yoffset': 1, 'border': 'top' } }
" Customize fzf colors to match your color scheme
let g:fzf_colors = {
	\ 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'Normal'],
	\ 'hl':      ['fg', "IncSearch"],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Label'],
	\ 'info':    ['fg', 'Comment'],
	\ 'border':  ['fg', 'Identifier'],
	\ 'prompt':  ['fg', 'Statement'],
	\ 'pointer': ['fg', 'Statement'],
	\ 'marker':  ['fg', 'Conditional'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment'] }

" Hide statusline
autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" History directory
let g:fzf_history_dir = $HOME . '/.local/share/fzf-history'

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
	command! -bang -nargs=* Find call fzf#vim#grep('rg --no-ignore --hidden --follow --ignore-case --column --no-heading --line-number --color=always --glob "!.git/*" --glob "!.svn/*" --glob "!node_modules/*" --glob "!.undodir/*" --glob "!.session.vim" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
endif


""""""""""
"" dominickng/fzf-session
" Create required directory if not present
if !isdirectory($HOME . '/.local/share/nvim-session')
	call mkdir($HOME . '/.local/share/nvim-session', 'p')
endif

let g:fzf_session_path = $HOME . '/.local/share/nvim-session'

" Create a session called {name}. The session will be automatically tracked.
" :Session {name}

" Load session called {name}.
" :SLoad {name}

" Delete session called {name}.
" :SDelete {name}

" Stop tracking the current active session and close all buffers.
" :SQuit

" List all available sessions.
" :SList

" Launch fzf prompt for fuzzy searching available sessions.
" :Sessions
nnoremap <silent> <leader><leader><leader>s :Sessions<CR>

" Default actions in the prompt:
" <Ctrl-X>: Delete session under the cursor
" Any other key: Open session under the cursor


""""""""""
"" kevinhwang91/rnvimr
if has('nvim')
	" Make Ranger replace Netrw and be the file explorer
	let g:rnvimr_enable_ex = 1

	" Make Ranger to be hidden after picking a file
	let g:rnvimr_enable_picker = 1

	" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
	let g:rnvimr_enable_bw = 1

	" Link CursorLine into RnvimrNormal highlight in the Floating window
	highlight link RnvimrNormal CursorLine

	" Disable a border for floating window
	let g:rnvimr_draw_border = 0
	" Change the border's color
	let g:rnvimr_border_attr = {'fg': ['fg', 'Function'], 'bg': -1}

	nnoremap <silent> <leader>r :RnvimrToggle<CR>
	tnoremap <silent> <leader>r <C-\><C-n>:RnvimrToggle<CR>

	" Customize the initial layout
	let g:rnvimr_layout = { 'relative': 'editor', 'width': float2nr(round(1.0 * &columns)), 'height': float2nr(round(1.0 * &lines)), 'col': float2nr(round(0.0 * &columns)), 'row': float2nr(round(0.0 * &lines)), 'style': 'minimal' }
endif


""""""""""
"" airblade/vim-gitgutter
" ]c					- jump to next hunk (change)
" [c					- jump to previous hunk (change)
" <leader>hs	- stage the hunk
" <leader>hu	- undo it
" <leader>hc	- stage the hunk and commit

" To stage part of any hunk:
" <leader>hp	- preview the hunk
" :wincmd P		- move to the preview window
" delete the lines you do not want to stage;
" stage the remaining lines: either write (:w) the window or stage via <leader>hs or :GitGutterStageHunk

" ic					- operates on all lines in the current hunk.
" ac					- operates on all lines in the current hunk and any trailing empty lines.


""""""""""
"" vim-diminactive
"let g:diminactive_enable_focus = 1
"let g:diminactive_use_colorcolumn = 1
"let g:diminactive_use_syntax = 1


""""""""""
"" vim-tmux-navigator
" <ctrl-h>	- Left
" <ctrl-j>	- Down
" <ctrl-k>	- Up
" <ctrl-l>	- Right
" <ctrl-\>	- Previous split
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
"let airline#extensions#tmuxline#snapshot_file = $HOME . '/.local/share/tmux.theme'


""""""""""
"" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'


""""""""""
"" nerdcommenter
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
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
"" tpope/vim-fugitive
" https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt
" Write to the current file's path and stage the results. When run in a work tree file, it is effectively git add. Elsewhere, it is effectively git-checkout. A great deal of effort is expended to behave sensibly when the work tree or index version of the file is open in another buffer.
noremap <leader>gad :Gwrite<CR>

noremap <leader>gpu :Gpush<CR>
noremap <leader>gpl :Gpull<CR>

noremap <leader>gdf :Gvdiff<CR>
noremap <leader>ggr :Ggrep<CR>

" Press - to add/reset a file's changes, or p to add/reset --patch.
noremap <leader>gst :Gstatus<CR>
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
"" cohama/lexima.vim
let g:lexima_enable_basic_rules = 1


""""""""""
"" dense-analysis/ale
" Recommended for macOS
let g:delve_backend = "native"
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '[%code%] %s [%severity%]'
let g:ale_ansible_ansible_lint_executable = 'ansible-lint -x ANSIBLE0204'
let g:ale_yaml_yamllint_options='-d "{extends: relaxed, rules: {line-length: disable}}"'
let g:ale_set_signs = 1
let g:delve_enable_syntax_highlighting = 1
let g:delve_new_command = "new"

" Hover window support
let g:ale_set_balloons = 0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_fixers = { '*': ['trim_whitespace', 'remove_trailing_lines'], 'javascript': ['prettier', 'eslint'], 'css' : ['prettier'], 'html' : ['prettier'], 'markdown' : ['prettier'], 'json': ['prettier'], 'sh': ['shfmt'], 'yaml': ['prettier'], 'c' : ['clang-format'], 'cpp' : ['clang-format'], 'python' : ['black'], 'go': ['gofmt'] }

let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'

nmap <silent> <leader>[g <Plug>(ale_previous_wrap)
nmap <silent> <leader>]g <Plug>(ale_next_wrap)


""""""""""
"" ncm2/ncm2
" use Tab to cycle in the popmenu, enter to  complete or expand
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <silent> <expr> <CR>
\	pumvisible() ?
\		(!empty(v:completed_item) ?
\		ncm2_ultisnips#expand_or("", 'n') :
\		"\<CR>\<c-r>=AutoPairsReturn()\<cr>") :
\		"\<CR>\<c-r>=AutoPairsReturn()\<cr>"
" alt-q to expand, alt-w to move forward, alt-e to move backward
imap <expr> <A-q> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
smap <A-q> <Plug>(ultisnips_expand)

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
au User Ncm2PopupClose set completeopt=menuone
set shortmess+=c
let g:ncm2#complete_length = 2


""""""""""
"" ultisnips
let g:snips_author = "stonevil"
let g:snips_email = "stonevil@gmail.com"
let g:snips_github = "https://github.com/stonevil"
let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<a-w>"
let g:UltiSnipsJumpBackwardTrigger	= "<a-e>"
let g:UltiSnipsRemoveSelectModeMappings = 0
" CompleteParameter
let g:complete_parameter_use_ultisnips_mapping = 1


""""""""""
"" Enter |Terminal-mode| automatically
if has('nvim')
	autocmd TermOpen * startinsert
endif


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
nnoremap <leader>l <C-^>

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
if exists('$TMUX') || $COLORTERM == 'truecolor'
	set termguicolors " Use the true color mode
	let ayucolor="dark"
	colorscheme ayu
else
	set t_Co=256
	colorscheme afterglow
endif

set colorcolumn=0
set background=dark
silent do ColorScheme

highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight Comment ctermbg=NONE guibg=NONE
"highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorColumn ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE


""""""""""
"" Reopen last position
if has('autocmd')
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
