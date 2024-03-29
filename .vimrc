"
" __   _(-)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
" ============================
" hopefully usable config
"
" based on work from Erik S. V. Jansson
"
"""""""""""""""""
"Encoding & Font"
"""""""""""""""""
set encoding=utf-8
"let &guifont='Hack Nerd Font Mono:h14
"above option is for Gvim. For cli vim set font in your terminal emulator
"""""""""
"Plugins"
"""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
""""""""""""""
"colorschemes"
""""""""""""""
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'joshdick/onedark.vim' " OneDark Theme

"""""""""""""""""""
"Completion plugin"
"""""""""""""""""""
Plug 'https://github.com/ackyshake/VimCompletesMe.git'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Use CocInstall coc-tsserver coc-css coc-html coc-sh

"""""""""""
"Snippets "
"""""""""""
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"""""""""""""""""""""""
"Nerdtree File Manager"
"""""""""""""""""""""""
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

""""""""""""""""""""""""""""""""""""""""""""
"Syntax highlighting and icons for nerdtree"
""""""""""""""""""""""""""""""""""""""""""""
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

""""""""""""
"Statusline"
""""""""""""
"hackline
"Plug 'https://github.com/jssteinberg/hackline.vim.git', {'branch': 'dev'}
"lightline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'luochen1990/rainbow'

"""""""""""""""""""""""""""""
"Css colors showing in files"
"""""""""""""""""""""""""""""
Plug 'https://github.com/ap/vim-css-color.git'

"""""""""""""""""""""""""""""""""""
"Comment and uncomment text easily"
"""""""""""""""""""""""""""""""""""
Plug 'preservim/nerdcommenter'

""""""""""""""
"Fuzzy Search"
""""""""""""""
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

""""""""""""""
"Syntax Check"
""""""""""""""
Plug 'https://github.com/vim-syntastic/syntastic.git'

Plug 'tpope/vim-fugitive' " Probably best Git wrapper.
Plug 'airblade/vim-gitgutter' " Git Gutter
Plug 'ConradIrwin/vim-bracketed-paste'

""""""""""""""
"Start Screen"
""""""""""""""
Plug 'mhinz/vim-startify'
"""""""""
"Floterm"
"""""""""
Plug 'voldikss/vim-floaterm'
""""""""""""
"indentline"
""""""""""""
Plug 'https://github.com/Yggdroot/indentLine.git'

call plug#end()

"""""""""
" Cursor "
""""""""""
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set mouse=a
set guicursor+=a:blinkon0

"""""""""""""
" Clipboard "
"""""""""""""
set clipboard=unnamedplus




"## General
set viminfo+=n~/.viminfo " Windows wants to use _viminfo >:(
set autowrite " Write automatically when :make, :next etc...
set autoread " Reload file when it has been changed externally.
set nobackup " No need for .bkp files when version control exist.
set nowritebackup " If Vim crashes often then turn backups on again, look at docs for more information.
set noswapfile " Don't create swap files, nowadays we should have enough memory to store a text file.
set complete-=i " Completion list for all included files is a bad idea, scanning could take a while.
set updatetime=100 "timeout default 4000
set sessionoptions-=options " Don't store options (global variables etc...) when making a session.

set splitbelow
set splitright

set undodir=~/.vim/undoes " Where do we store all this awesomeness?!?!
set undofile " Persistent undos are completely freaking awesome!!!

set history=1024 " Defines the number of stored commands Vim can remember, doesn't really matter :).


"## Autocompletions
set omnifunc=syntaxcomplete#Complete " Enables only the default Vim auto-completion (quite fast!!!).
set completeopt+=longest " Attempts to insert longest obviously current common match found so far.
set completeopt-=preview " Sometimes the [Scratch] preview window will pop-up. We don't want that.
let g:vcm_direction='p' " First choice should be the *closest* matching entry (as Bram intended).

"## Formatting
set expandtab " Expand tab characters to space characters.
set shiftwidth=4 " One tab is now 4 spaces.
set shiftround " Always round up to the nearest tab.
set tabstop=4 " This one is also needed to achieve the desired effect.
set softtabstop=4 " Enables easy removal of an indentation level.

set autoindent " Automatically copy the previous indent level. Don't use smartindent!!!
set backspace=2 " Used for making backspace work like in most other editors (e.g. removing a single indent).
set wrap " Wrap text. This is also quite optional, replace with textwidth=80 is you don't want this behaviour.
set lazyredraw " Good performance boost when executing macros, redraw the screen only on certain commands.
set breakindent
set breakindentopt=shift:2
set showbreak=↳


"## Searching
set ignorecase " Search is not case sensitive, which is usually what we want.
set smartcase " Will override some ignorecase properties, when using caps it will do a special search.
set incsearch " Enables the user to step through each search 'hit', usually what is desired here.
set hlsearch " Will stop highlighting current search 'hits' when another search is performed.
set magic " Enables regular expressions. They are a bit like magic (not really though, DFA).

"## Interface
set ffs=unix,dos,mac " Prioritize unix as the standard file type.
set encoding=utf-8 " Vim can now work with a whole bunch more characters (powerline too).
set scrolloff=4 " The screen will only scroll when the cursor is 8 characters from the top/bottom.
set foldmethod=indent " Pressing zc will close a fold at the current indent while zo will open one.
set foldopen+=jump " Additionally, open folds when there is a direct jump to the location.
set foldlevel=99 " many folds open

set wildmenu " Enable the 'autocomplete' menu when in command mode (':').
set wildmode=list:longest,full
set cursorline " For easier cursor spotting. Completely optional though (but so is bathing).
set colorcolumn=80
set shortmess=at " Shorten some command mode messages, will keep you from having to hit ENTER all the time.
" set cmdheight=2 " Might decrease the number of times for hitting enter even more, double default height.
set stal=2 " Always show the tab lines, which makes the user interface a bit more consistent.

set showmatch " Will highlight matching brackets.
set mat=2 " How long the highlight will last.
set number " Show line numbers on left side.
set relativenumber " Enables the user to easily see the relative distance between cursor and target line.
set ttyfast " Will send characters over a terminal connection faster. We do have fast connections after all.
set ruler " Always show current cursor position, which might be needed for the character column location.
set hidden " Abandon buffer when closed, which is usually what we want to do in this case.
set title
set signcolumn=yes numberwidth=4

syntax on " The most important feature when coding. Vim please bless us with this option right now!.
set laststatus=2 " Always have a status line, this is required in order for Lightline to work correctly.
set noshowmode " Disables standard -INSERT-, -NORMAL-, etc... Lightline will provide a better looking one for us.

set list " Enables the characters to be displayed.
" Useful for showing trailing whitespace and others.
set listchars=tab:›\ ,trail:•,extends:>,precedes:<,nbsp:_
" set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·
" set listchars=tab:>·,trail:~,extends:>,precedes:<

set timeout           " for mappings
set timeoutlen=1000   " default value
set ttimeout          " for key codes
set ttimeoutlen=10    " unnoticeable small value

"""""""
"Theme"
"""""""
" Inspect $TERM instad of t_Co
if &term =~ '256color'
  " Enable true (24-bit) colors instead of (8-bit) 256 colors.
  if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
  colorscheme onedark
endif
  colorscheme onedark

set background=dark
"Indentline follow theme change to 1 if colors are fucked
let g:indentLine_setColors = 0
let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

" - Popup window (center of the screen)
if has ('popupwin')
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif


""""""""""""""""""""""""
"Settings for syntastic"
""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
"0 off
"automatically.
"1 the error window will be automatically opened when errors are
"detected, and closed when none are detected.
"2 the error window will be automatically closed when no errors are
"detected, but not opened automatically.
"3 the error window will be automatically opened when errors are
"detected, but not closed automatically.
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Colors have been tested with gruvbox, modify to your liking
"Error sign on the right
highlight SyntasticErrorSign ctermfg=red ctermbg=yellow
"Error line highlight
highlight SyntasticErrorLine ctermbg=black

let g:syntastic_auto_jump = 3
"0 off
"1 the cursor will always jump to the first issue detected,
"regardless of type.
"2 the cursor will jump to the first issue detected, but only if
"this issue is an error.
"3 the cursor will jump to the first error detected, if any. If
"all issues detected are warnings, the cursor won't jump.

"""""""""""""""""""
" Custom Mappings "
"""""""""""""""""""
"LEADER"
"leader key is space
let mapleader =" "

" Will remove latest search/replace highlight.
nnoremap <silent> <leader><CR> :silent! noh<CR>

""""""""""""""""""""""""""""""""""""""""
"Keybindings for sane buffer navigation"
""""""""""""""""""""""""""""""""""""""""
set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <C-LEFT> <C-w>h
map <C-DOWN> <C-w>j
map <C-UP> <C-w>k
map <C-RIGHT> <C-w>l

map <s-LEFT> :vertical resize +5 <Cr>
map <s-RIGHT> :vertical resize -5 <Cr>
map <s-UP> :resize +5 <Cr>
map <s-DOWN> :resize -5 <Cr>

nnoremap <M-Left> :tabprevious<CR>
nnoremap <M-Right> :tabnext<CR>
"Keybindings for tab navigation with leader and number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

noremap <leader>0 :tablast<cr>
nnoremap <leader>x :tabclose<Cr>
map <leader>tm :tabmove<Cr>

map <leader>c :Colors<Cr>
map <leader>fb :Buffers<Cr>
map <leader>ff :Files<Cr>
map <leader>fw :Windows<Cr>
map <leader>fh :History<Cr>
map <leader>fm :Maps<Cr>
map <leader>t :FloatermToggle<Cr>
map <leader>fg :GFiles<cr>
map <leader>fl :Lines<cr>
nnoremap <leader>v :FloatermNew vifm <Cr>
nnoremap <leader>r :FloatermNew ranger <Cr>
nnoremap <leader>T :tabnew file <Cr>

" Useful to toggle the NERDTree window back and forth.
nnoremap <leader>e :NERDTreeToggle<cr>
let NERDTreeShowHidden=1

" Floaterm
let g:floaterm_opener = 'edit'
vnoremap <leader>m :FloatermNew --autoclose=2 vifm<CR>
nnoremap <leader>m :FloatermNew --autoclose=2 vifm<CR>
map <leader>t :FloatermToggle<Cr>

" Yank(copy) to system clipboard
noremap <Leader>y "+y
noremap <leader>p "+p

" Toggle pastemode, doesn't indent
set pastetoggle=<leader>i

" Toggle relativenumber
nnoremap <silent> <Leader>r :set relativenumber!<CR>
" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Quickly switch buffers
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bf :b#<CR>
nnoremap <Leader>b1 :1b<CR>
nnoremap <Leader>b2 :2b<CR>
nnoremap <Leader>b3 :3b<CR>
nnoremap <Leader>b4 :4b<CR>
nnoremap <Leader>b5 :5b<CR>
nnoremap <Leader>b6 :6b<CR>
nnoremap <Leader>b7 :7b<CR>
nnoremap <Leader>b8 :8b<CR>
nnoremap <Leader>b9 :9b<CR>
nnoremap <Leader>b0 :10b<CR>
" close buffer
nnoremap <silent> <leader>bd :bd<CR>

" kill buffer
nnoremap <silent> <leader>bk :bd!<CR>

" Highlight last inserted text
nnoremap gV '[V']

" Quickly edit/source .vimrc
noremap <Leader>ve :edit $HOME/.vimrc<CR>
noremap <Leader>vs :source $HOME/.vimrc<CR>

" Fugitive Keybinds
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

""""""""""
"Functions
""""""""""
" Toggle syntax highlighting
function! ToggleSyntaxHighlighting()
  if exists('g:syntax_on')
    syntax off
  else
    syntax enable
  endif
endfunction
nnoremap <Leader>s :call ToggleSyntaxHighlighting()<CR>

""" Highlight characters past 79, toggle with <Leader>hl
""" You might want to override this function and its variables with
""" your own in .vimrc.last which might set for example colorcolumn or
""" even the textwidth. See https://github.com/timss/vimconf/pull/4
let g:overlength_enabled = 0
highlight OverLength ctermbg=238 guibg=#444444

function! ToggleOverLength()
  if g:overlength_enabled == 0
    match OverLength /\%79v.*/
    let g:overlength_enabled = 1
    echo 'OverLength highlighting turned on'
  else
    match
    let g:overlength_enabled = 0
    echo 'OverLength highlighting turned off'
  endif
endfunction
nnoremap <Leader>hl :call ToggleOverLength()<CR>

" Toggle text wrapping, wrap on whole words
" For more info see: http://stackoverflow.com/a/2470885/1076493
function! WrapToggle()
  if &wrap
    set list
    set nowrap
  else
    set nolist
    set wrap
  endif
endfunction
nnoremap <Leader>w :call WrapToggle()<CR>

" Strip trailing whitespace, return to cursor at save
function! StripTrailingWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

"""""""""""
"Lightline
"""""""""""
""""""""""""""""""""""""""
"for lightline status bar"
""""""""""""""""""""""""""
"minimal info on narrow splits
let g:lightline = {
      \'component_function': { 'lineinfo': 'LightlineLineinfo', }
      \}

"### LightLine Components: {
    function! LightLineModified()
        if &modified
            return "+"
        else
            return ""
        endif
    endfunction

    function! LightLineFugitive()
        if exists("*fugitive#head")
            let branch = FugitiveHead()
"            let branch = fugitive#head()
            return branch !=# '' ? ' '.branch : ' [No Head]'
        else
            return ' [No Head]'
        endif
        return ''
    endfunction

    function! LightLineFilename()
        return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
             \ ('' != expand('%:f') ? expand('%:f') : '[No Name]') .
             \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
    endfunction

    function! GitStatus()
        let [a,m,r] = GitGutterGetHunkSummary()
        return printf('+%d ~%d -%d', a, m, r)
    endfunction

function! LightlineLineinfo() abort
    if winwidth(0) < 86
        return ''
    endif
    let l:current_line = printf('%-3s', line('.'))
    let l:max_line = printf('%-3s', line('$'))
    let l:lineinfo = ' ' . l:current_line . '/' . l:max_line
    return l:lineinfo
endfunction

function! LightLineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

" let g:lightline = {
"       \'component_function':  { 'mode': 'LightlineMode' }
"       \}
"
" function! LightlineMode() abort
"     let ftmap = {
"       \ 'NERDTree': 'NERDTree',
"       \ }
"     return get(ftmap, &filetype, lightline#mode())
" endfunction

" no statusline in nerdtree window
augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

function s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfunction

"let g:lightline = {
"      \ 'colorscheme': 'onedark',
"      \ 'active': {
"      \ 'left': [ [ 'mode' ], [ 'readonly', 'absolutepath', 'modified' ] ],
"      \ 'right': [ [ 'lineinfo' ],[ 'percent' ],[ 'filetype'] ] },
"      \ 'component': {
"      \ 'charvaluehex': '0x%B'
"      \ },
"      \ }
" A LightLine Theme
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \  'left': [[ 'mode' ], [ 'paste' ], [ 'fugitive' ], [ 'gitstatus' ], [ 'readonly', 'filename', 'modified' ]],
    \  'right': [[ 'linenums' ], [ 'percent' ], [ 'filetype' ], [ 'fileformat', 'fileencoding' ]]
    \ },
    \ 'inactive': {
    \  'left': [[ 'mode' ], [ 'fugitive' ], [ 'gitstatus' ], [ 'readonly', 'filename', 'modified' ]],
    \  'right': [[ 'linenums' ], [ 'filetype' ], [ 'fileformat', 'fileencoding' ]]
    \ },
    \ 'tabline': {
    \   'left': [ ['buffers'] ],
    \   'right': [ ['close'] ]
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ },
    \ 'component': {
    \   'linenums': '☰  %3l/%L:%-2c',
    \   'filetype': '%{&ft!=#""?&ft:"[No Type]"}'
    \ },
    \ 'component_function': {
    \   'gitstatus': 'GitStatus',
    \   'fugitive2': 'FugitiveHead',
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename',
    \ },
    \ 'mode_map': {
    \ 'n' : 'N',
    \ 'i' : 'I',
    \ 'R' : 'R',
    \ 'v' : 'V',
    \ 'V' : 'VL',
    \ "\<C-v>": 'VB',
    \ 'c' : 'C',
    \ 's' : 'S',
    \ 'S' : 'SL',
    \ "\<C-s>": 'SB',
    \ 't': 'T',
    \ },
    \ }
"    \ 'separator':    { 'left': '', 'right': '' },
"    \ 'subseparator': { 'left': '', 'right': '' }



""""""""""
"NERDTree
""""""""""
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"nerdtree width
let g:NERDTreeWinSize=20

"remove press ? for help on top of nerdtree
let NERDTreeMinimalUI=1
"disable 80 extentions of nerdtree for less lag

let g:NERDTreeLimitedSyntax = 1

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"""""""""""""""""""""""""""""""""
" NERDTree Functions and colors "
"""""""""""""""""""""""""""""""""
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule


"""""""""""""""""""""""""""""""
"Options For The Startify Menu"
"""""""""""""""""""""""""""""""
 let g:startify_custom_header =
       \ startify#pad(split(system('figlet -w 100 Wim'), '\n'))
"Incase you are insane and want to open a new tab with Goyo enabled
 autocmd BufEnter *
       \ if !exists('t:startify_new_tab') && empty(expand('%')) && !exists('t:goyo_master') |
       \   let t:startify_new_tab = 1 |
       \   Startify |
       \ endif
"Bookmarks. Syntax is clear.add yours
let g:startify_bookmarks = [ {'A': '~/.config/awesome/rc.lua'},{'Z': '~/.config/zsh/.zshrc'},{'B': '~/.bashrc'},{'V': '~/.vimrc'}]
    let g:startify_lists = [
          \ { 'type': 'bookmarks' , 'header': ['   Bookmarks']      } ,
          \ { 'type': 'files'     , 'header': ['   Recent'   ]      } ,
          \ { 'type': 'sessions'  , 'header': ['   Sessions' ]      } ,
          \ { 'type': 'commands'  , 'header': ['   Commands' ]      } ,
          \ ]
"cant tell wtf it does so its commented
" \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
let g:startify_files_number = 5


hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240

let g:rainbow_active = 1   " rainbow brackets

""""""""""""""""
"FloatermToggle"
""""""""""""""""
let g:floaterm_autohide = 0
let g:floaterm_autoclose = 2
let g:floaterm_height = 30
let g:floaterm_width  = 120

""""""""""
"Snippets"
""""""""""
"Use END key to trigger the snippets, default was TAB but that conflicts with
"the Completion trigger see :h keycodes to change this to sth else
"use Ctrl j and k to move visually within the snippet that was just triggered
"Ctrl PGDN lists the available snippets
let g:UltiSnipsExpandTrigger='<END>'
let g:UltiSnipsListSnippets='<c-PageDown>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'


"""""""""""
"Autogroups
"""""""""""
augroup StripTrailingWhitespace
  autocmd!
  autocmd FileType c,cpp,cfg,conf,css,html,perl,python,sh,tex,yaml
    \ autocmd BufWritePre <buffer> :call
    \ StripTrailingWhitespace()
augroup END


" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
  augroup END
endif

autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePost ~/.Xresources call system('xrdb -load ~/.Xresource')

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

