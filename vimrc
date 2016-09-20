" :help window-moving
"
"

colorscheme default 
"syntax on
syntax enable

set ts=2
set shiftwidth=2
set expandtab
"set nowrap
"set nowrapscan
set mouse=nvi
set hlsearch

" Autocomplete mode
set wildmode=longest,list,full
set wildmenu

" Blocket Platform
" Correct the file type
au BufNewFile,BufRead bconf.txt.* set filetype=cfg
au BufNewFile,BufRead *.html.tmpl set filetype=html
au BufNewFile,BufRead *.sql.tmpl set filetype=sql

" Line Numbers
set rnu
if &diff
	set nu
endif

let mapleader = "\<Space>"

" open newline without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
" ctrl + n opens nerdtree
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
" F3 uses Ack! of word under cursor
map <F3> "myiw:Ag! <C-r>m<CR>
map <F5> "myiw:Ag! "def <C-r>m<CR>"
map <F7> :RuboCop<CR>
" Scroll without moving the cursor
map <C-Up> <C-e>
map <C-Down> <C-y>
imap <C-Up> <C-o><C-e>
imap <C-Down> <C-o><C-y>

map <Leader>ap $p
map <Leader>riw viwp

map <Leader>w :w<CR>

map <Leader>ovrc :tabe ~/.vimrc<CR>
map <Leader>svrc :source ~/.vimrc<CR>

map <Leader>sp :set paste<CR>
map <Leader>snp :set nopaste<CR>
 
map <Leader>fmi :set foldmethod=indent<CR>
map <Leader>fms :set foldmethod=syntax<CR>
map <Leader>fl0 :set foldlevel=0<CR>
map <Leader>fl1 :set foldlevel=1<CR>
map <Leader>fl2 :set foldlevel=2<CR>
map <Leader>fl3 :set foldlevel=3<CR>
map <Leader>fl9 :set foldlevel=9<CR>

" Save as a new file name and open it
command! -nargs=1 WE :w <args> | :e <args>
command! -nargs=1 WED :w %:h/<args> | :e %:h/<args>
" Open vimrc in a split window
command! Vimrc :sp $MYVIMRC

"auto indent
set ai
set si

" fold method
set foldmethod=indent
set foldlevel=0 " unfold by default
" za zA zM zR
" set foldmethod=manual
" zf3j

" git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=55

" ctrlp ignores
" F5 refresh cache
let g:ctrlp_max_files = 20000
let g:ctrlp_max_depth = 40
let g:ctrlp_custom_ignore = {
	\ 'dir': '\vvirtualenv'
	\ }

let &tags = './tags,tags,' . substitute(expand("%:p:h"), "\(^\/home\/prosanes\/dev\/.*/\).*$", "\1", "")

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

Plugin 'morhetz/gruvbox'
" colorscheme gruvbox

Plugin 'mhinz/vim-startify'

Plugin 'gmarik/vundle'

Plugin 'kien/ctrlp.vim'

Plugin 'airblade/vim-gitgutter'
let g:gitgutter_realtime = 0
" usage: :GitGutterDisable :GitGutterEnable :GitGutterToogle
" jump to next unk ]h previous hunk [h
"
Plugin 'tpope/vim-fugitive'
"[2014-10-27 17:05:17] Helptags:
"[2014-10-27 17:05:17] :helptags /home/prosanes/.vim/bundle/vundle/doc/
"[2014-10-27 17:05:17] :helptags /home/prosanes/.vim/bundle/ctrlp.vim/doc/
"[2014-10-27 17:05:17] :helptags /home/prosanes/.vim/bundle/vim-gitgutter/doc/
"[2014-10-27 17:05:17] :helptags /home/prosanes/.vim/bundle/vim-fugitive/doc/

Plugin 'scrooloose/syntastic'
" :SyntasticCheck pylint

Plugin 'rking/ag.vim'
" :Ag [options] {pattern} [{directory}]
" Search recursively in {directory} (which defaults to the current directory)
" for the {pattern}.
"
" Files containing the search term will be listed in the split window, along
" with the line number of the occurrence, once for each occurrence. [Enter] on
" a line in this window will open the file, and place the cursor on the
" matching line.
"
" Just like where you use :grep, :grepadd, :lgrep, and :lgrepadd, you can use
" :Ag, :AgAdd, :LAg, and :LAgAdd respectively. (See doc/ag.txt, or install and
" :h Ag for more information.)

Plugin 'scrooloose/nerdtree'

Plugin 'regedarek/ZoomWin'
" <c-w>o ZoomWin in and out

Plugin 'vim-scripts/tComment'
" gcc to comment one line
" gc to multiple visual lines

Plugin 'vim-utils/vim-ruby-fold'

Plugin 'editorconfig/editorconfig-vim'

Plugin 'ngmy/vim-rubocop'

Plugin 'mickaobrien/vim-stackoverflow'

Plugin 'leafgarland/typescript-vim'

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

" Syntastic Checkers
let g:syntastic_enable_signs=1                                                                     
let g:syntastic_auto_jump=0                                                                        
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'                           
let g:syntastic_mode_map = { 'mode': 'active',                                                     
                           \ 'active_filetypes': ['python', 'php'],                                
                           \ 'passive_filetypes': ['puppet'] }                                     

let g:syntastic_python_pylint_args = "--disable=W0312,C0111"
let g:syntastic_ruby_checkers = ['rubocop', 'ruby-lint']
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>


" vim startify
let g:startify_change_to_vcs_root = 1
let g:startify_bookmarks = [ 
        \ { 'co': '~/dev/checkout' },
        \ { 'am': '~/dev/amsterdam' },
        \ { 'lb': '~/dev/library' },
        \ { 'cb': '~/dev/opsworks-cookbooks' },
        \]
let g:startify_list_order = [
        \ ['   These are my bookmarks:'],
        \ 'bookmarks',
        \ ['   My most recently', '   used files'],
        \ 'files',
        \ ['   My most recently used files in the current directory:'],
        \ 'dir',
        \ ['   These are my sessions:'],
        \ 'sessions',
        \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Tab navigation
noremap <C-Right> :tabn<CR> 
inoremap <C-Right> <esc>:tabn<CR><Insert> 
noremap <C-Left> :tabprev<CR> 
inoremap <C-Left> <ESC>tabprev<CR><Insert>
noremap <f9> :set filetype=html<CR>

colorscheme gruvbox
set background=dark

" To work webpack --watch
"Vim
"On some machines Vim is preconfigured with the backupcopy option set to auto. This could potentially cause problems with the system’s file watching mechanism. Switching this option to yes will make sure a copy of the file is made and the original one overwritten on save.
set backupcopy=yes

" To allow gF to work based on current FileType
" http://stackoverflow.com/questions/33093491/vim-gf-with-file-extension-based-on-current-filetype
augroup suffixes
    autocmd!

    let associations = [
                \["javascript", ".js,.javascript,.es,.esx,.json,.jsx"],
                \["python", ".py,.pyw"]
                \]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup END
