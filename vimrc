""""""""""""""
""" Vundle """
""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/.vim/bundle/')

" let Vundle manage Vundle
" required! 

Plugin 'morhetz/gruvbox'
" colorscheme gruvbox

Plugin 'mhinz/vim-startify'

Plugin 'gmarik/vundle'

Plugin 'ctrlpvim/ctrlp.vim'

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

Plugin 'vim-scripts/tComment'
" gcc to comment one line
" gc to multiple visual lines

Plugin 'vim-utils/vim-ruby-fold'

Plugin 'editorconfig/editorconfig-vim'

Plugin 'ngmy/vim-rubocop'

Plugin 'easymotion/vim-easymotion'

Plugin 'tpope/vim-surround'

Plugin 'leafgarland/typescript-vim'

Plugin 'hashivim/vim-vagrant'

Plugin 'lrvick/Conque-Shell'

Plugin 'vim-scripts/taglist.vim'

Plugin 'udalov/kotlin-vim'

Plugin 'elixir-lang/vim-elixir'

Plugin 'jstemmer/gotags'

Plugin 'fatih/vim-go'

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



""""""""""""""""""""""""
""" Basic VIM Config """
""""""""""""""""""""""""
colorscheme default 

"syntax highlight on
syntax enable

" Basic Default File layout
set ts=2
set shiftwidth=2
set expandtab
set tabstop=2
set rnu
set nu
if &diff
	set nu
endif

"auto indent
set ai
set si

" fold method
set foldmethod=indent
" Self help:
" za zA zM zR
" set foldmethod=manual
" zf3j

"autocmd BufNewFile,BufRead *.go set noexpandtab

" Mouse
set mouse=nvi

" Search options
set hlsearch
set ignorecase
set smartcase

" Autocomplete mode
set wildmode=longest,list,full
set wildmenu

" Disable .sw* files
set nobackup
set noswapfile

" Tags
let &tags = './tags,tags,' . substitute(expand("%:p:h"), "\(^\/home\/prosanes\/dev\/.*/\).*$", "\1", "")

set backupcopy=yes
" To work webpack --watch
"Vim
"On some machines Vim is preconfigured with the backupcopy option set to auto. This could potentially cause problems with the system’s file watching mechanism. Switching this option to yes will make sure a copy of the file is made and the original one overwritten on save.

"""""""""""""""""""""""""
""" Native VIM Remaps """
"""""""""""""""""""""""""

let mapleader = "\<Space>"

" open newline without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Scroll without moving the cursor
map <C-Up> <C-e>
map <C-Down> <C-y>
imap <C-Up> <C-o><C-e>
imap <C-Down> <C-o><C-y>

"yank filename
nmap yp :let @" = expand("%") <CR>

" Tab navigation
noremap <C-Right> :tabn<CR> 
inoremap <C-Right> <esc>:tabn<CR><Insert> 
noremap <C-Left> :tabprev<CR> 
inoremap <C-Left> <ESC>tabprev<CR><Insert>
noremap <f9> :set filetype=html<CR>

" Yank && Pastes
map <Leader>ap $p
map <Leader>riw viwp
map <Leader>y "+y
map <Leader>p "+p

" Write
map <Leader>w :w<CR>

" Paste mode
map <Leader>sp :set paste<CR>
map <Leader>snp :set nopaste<CR>
 
" Folds
map <Leader>fmi :set foldmethod=indent<CR>
map <Leader>fms :set foldmethod=syntax<CR>
map <Leader>fmm :set foldmethod=manual<CR>
map <Leader>fl0 :set foldlevel=0<CR>
map <Leader>fl1 :set foldlevel=1<CR>
map <Leader>fl2 :set foldlevel=2<CR>
map <Leader>fl3 :set foldlevel=3<CR>
map <Leader>fl9 :set foldlevel=9<CR>

map <Leader>df :set foldmethod=syntax<CR>zadd


"""""""""""""""""""""""""""
""" Native VIM Commands """
"""""""""""""""""""""""""""

" Save as a new file name and open it
command! -nargs=1 WE :w <args> | :e <args>
command! -nargs=1 WED :w %:h/<args> | :e %:h/<args>

"""""""""""""""""""""""
""" Maps to Plugins """
"""""""""""""""""""""""

""" Nerd Tree
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>

""" Ack (Ag)
map <F3> "myiw:Ag! <C-r>m<CR>
map <F5> "myiw:Ag! "def <C-r>m<CR>"

""" EasyMotion
map \ <Plug>(easymotion-prefix)

""" TagList
map <Leader>t :TlistToggle<CR>

""" Syntastic
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

""""""""""""""""""""""""""
""" Vim Configurations """
""""""""""""""""""""""""""

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

" Fold level per file configuration
if !exists('*FoldLevelDependingOnStartFile')
  function FoldLevelDependingOnStartFile()
    if @% == ""
      " No filename for current bugger
      set foldlevel=9
    else
      set foldlevel=0
    endif
  endfunction
endif
au VimEnter * call FoldLevelDependingOnStartFile()

""""""""""""""""""""""""""""""
""" Plugins Configurations """
""""""""""""""""""""""""""""""

" CtrlP
  let g:ctrlp_max_files = 20000
  let g:ctrlp_max_depth = 40
  let g:ctrlp_custom_ignore = 'tmp/\|node_modules\|client/node_modules\|DS_Store\|\.git$'

" Syntastic Checkers
  let g:syntastic_enable_signs=1                                                                     
  let g:syntastic_auto_jump=0                                                                        
  let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'                           
  let g:syntastic_mode_map = { 'mode': 'active',                                                     
                             \ 'active_filetypes': ['python', 'php', 'js', 'go'],                                
                             \ 'passive_filetypes': ['puppet', 'jsx'] }                                     
  let g:syntastic_python_pylint_args = "--disable=W0312,C0111"
  let g:syntastic_ruby_checkers = ['rubocop', 'ruby-lint']
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_go_checkers = ['gometalinter']

" Startify
  let g:startify_change_to_vcs_root = 1
  let g:startify_bookmarks = [ 
          \ { 'example': '~/dev/example' },
          \]
  let g:startify_list_order = [
          \ ['   My most recently used files in the current directory:'],
          \ 'dir',
          \ ['   My most recently', '   used files'],
          \ 'files',
          \ ['   These are my bookmarks:'],
          \ 'bookmarks',
          \ ['   These are my sessions:'],
          \ 'sessions',
          \ ]

" VimGo
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

" Gruvbox
if filereadable( expand("$HOME/.vim/bundle/gruvbox/colors/gruvbox.vim") )
	colorscheme gruvbox
endif
set background=dark

""""""""""""""""""""""""""
""" File/Language Based configs """
""""""""""""""""""""""""""

" git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=55

" GoLint on .go save
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
autocmd BufWritePost,FileWritePost *.go execute 'GoLint' | cwindow

" Ruby
autocmd BufWritePost *.rb silent exec "!ripper-tags -R --exclude=vendor"

