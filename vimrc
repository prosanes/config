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

" changing windows with the default vim arrows
nmap h <C-W>h
nmap l <C-w>l
nmap j <C-w>j
nmap k <C-w>k

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
set foldmethod=syntax
set foldlevel=99 " unfold by default
" za zA

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
	\ 'dir': '\vregress_final|build|platform'
	\ }

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-fugitive'
" usage: :GitGutterDisable :GitGutterEnable :GitGutterToogle
" jump to next unk ]h previous hunk [h
":BundleInstall to run
":BundleUpdate
"execute pathogen#infect() to automatically update

filetype plugin indent on

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
