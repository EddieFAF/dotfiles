"" Plugin: Airline {{{
  " Use statusline more effective
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  if exists('$DISPLAY')
    " Automatic population of the g:airline_symbols dictionary with
    " powerline symbols
    let g:airline_powerline_fonts=1
  endif
  " Specify theme for airline
  let g:airline_theme='wombat'
  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#tabline#left_sep=''
  let g:airline#extensions#tabline#left_alt_sep='|'
  " Enable displaying tabs, regardless of number
  let g:airline#extensions#tabline#show_tabs=1
  " Disable displaying buffers with a single tab
  let g:airline#extensions#tabline#show_buffers=0
  let g:airline#extensions#tabline#formatter='default'
  " Customize a left side of airline
  let g:airline_section_b='%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
  " Customize a right side of airline
  let g:airline_section_y='[%{&fileformat}/%{strlen(&fenc)?&fenc:&enc}]'
  " Use airline's showmode
  set noshowmode
"" }}}

"" Plugin: dracula }}}
Plug 'dracula/vim',{'as':'dracula'}

"" }}}

