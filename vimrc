" :help window-moving

colorscheme default 
"syntax on
syntax enable

set ts=4
set shiftwidth=4
set noexpandtab
"set nowrap
"set nowrapscan
set mouse=nvi

" Autocomplete mode
set wildmode=longest,list,full
set wildmenu

" Blocket Platform
" Correct the file type
au BufNewFile,BufRead bconf.txt.* set filetype=cfg
au BufNewFile,BufRead *.html.tmpl set filetype=html
au BufNewFile,BufRead *.sql.tmpl set filetype=sql

" Line Numbers
set nu
if &diff
	set nu
endif

" open newline without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Save as a new file name and open it
command! -nargs=1 WE :w <args> | :e <args>
command! -nargs=1 WED :w %:h/<args> | :e %:h/<args>
" Open vimrc in a split window
command! Vimrc :sp $MYVIMRC
" Automaticly source vimrc file after its saved
autocmd bufwritepost $MYVIMRC source $MYVIMRC

"auto indent
set ai
set si

" fold method
set foldmethod=indent
set foldlevel=99 " unfold by default
" za zA zM zR
" set foldmethod=manual
" zf3j

" git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=55

"GF working with templates
set path=.,~,/usr/include
set includeexpr=substitute(v:fname,'^\\(.*\\)$','templates/\\1.tmpl','g')

" ctrlp ignores
" F5 refresh cache
let g:ctrlp_max_files = 20000
let g:ctrlp_max_depth = 40
let g:ctrlp_custom_ignore = {
	\ 'dir': '\vregress_final|build|platform|virtualenv'
	\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')

" let Vundle manage Vundle
" required! 

Plugin 'gmarik/vundle'

Plugin 'kien/ctrlp.vim'

Plugin 'airblade/vim-gitgutter'
" usage: :GitGutterDisable :GitGutterEnable :GitGutterToogle
" jump to next unk ]h previous hunk [h
"
Plugin 'tpope/vim-fugitive'
"[2014-10-27 17:05:17] Helptags:
"[2014-10-27 17:05:17] :helptags /home/prosanes/.vim/bundle/vundle/doc/
"[2014-10-27 17:05:17] :helptags /home/prosanes/.vim/bundle/ctrlp.vim/doc/
"[2014-10-27 17:05:17] :helptags /home/prosanes/.vim/bundle/vim-gitgutter/doc/
"[2014-10-27 17:05:17] :helptags /home/prosanes/.vim/bundle/vim-fugitive/doc/

" Examples:
" The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
" 
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! FindBconfKey()
	let key = expand("<cWORD>")
	let key = substitute(key, "[^a-zA-Z0-9._]\\+", "", "g")
	echo "Searching: " . key
	let options = split(system("grep -n " . key . " $(find conf/ -type f -name bconf\\.*)"), "\n")
	if len(options) == 0
		echo "No results found!"
		return
	endif
	let num_options = []
	for line in options 
		call add(num_options, ((len(num_options) + 1) . " " . line) )
	endfor
	let answer = input(join(num_options, "\n") . "\n")
	if !empty(answer)
		let selected = split(options[answer - 1], ":")
		execute "tabe " . selected[0]
		execute ":" . selected[1]
	endif
endfunction
noremap gb :call FindBconfKey() <CR>

"yank filename
nmap yp :let @" = expand("%") <CR>

" Identando JSON no vim:
" 
" Pedro Lira [14:43]
" :%!python -m json.tool
" 
" Pedro Lira [14:43]
" Identando XML no vim:
" 
" Pedro Lira [14:44]
" :%!xmllint --format -
