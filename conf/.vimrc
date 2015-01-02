source ~/.vim/vimrc
:set dictionary+=~/.vim/dict/opscode_chef.dict/*.dict

" Toggle spell checking on and off with `,s`
let mapleader = ","
nmap <silent> <leader>s :set spell!<CR>
" z= for correct

" Set region to British English
" set spelllang=en_gb

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
