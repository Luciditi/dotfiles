"""""""LUCIDITI .VIMRC""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""VUNDLE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.vundle.vimrc

"""""""SOURCES""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup SOURCES

augroup END

"""""""TEMPLATE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup TEMPLATE

augroup END

"""""""DEBUGGING""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup DEBUGGING

  " Use :call ToggleVerbose() to dump a verbose log
  function! ToggleVerbose()
      if !&verbose
          set verbosefile=~/.vim/verbose.log
          set verbose=15
      else
          set verbose=0
          set verbosefile=
      endif
  endfunction

augroup END

"""""""USEFUL COMMANDS""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup USEFUL COMMANDS
"  __           :  _____________________________________.
"  ``           :  Return to previous cursor before jump.
"  gi           :  Last Place in Insert Mode.

augroup END

"""""""NEOVIM"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup NEOVIM
  "CONFIGURE FOR NEOVIM
  if has('nvim')
  endif
augroup END

"""""""ABBREVIATIONS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup ABBREVIATIONS
augroup END

"""""""AUTOCOMPLETE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup AUTOCOMPLETE
  "j/k to naviate
  "autocomplete menu
  ino <expr> J ((pumvisible())?("\<C-n>"):("J"))
  ino <expr> K ((pumvisible())?("\<C-p>"):("K"))

  "Dictionary complete with Tab+d
  ino <Tab>d <C-X><C-k>

  "Line complete with Tab+l
  ino <Tab>l <C-x><C-l>

  "Autocomplete from dictionary as well
  set complete+=k

  "Personal Dictionary complete with C-d
  silent! set dict +=~/.vim/dictionaries/personal.dict
augroup END

"""""""BAD COMMANDS""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup BAD COMMANDS
augroup END

"""""""COMMANDS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup COMMANDS
  "Set leader to Space
  let mapleader = "\<Space>"
  let g:mapleader = "\<Space>"
  let g:maplocalleader = "\<Space>"

  "Map g+j/k to move down to the first no blank character
  no gj +
  no gk -

  "Map g+J/K to move down to the first empty line
  no gJ }
  no gK {
  " FIX FOR SynHighlight: }

  "Map jk for escaping insert/visual/comman mode
  ino jk <Esc>
  ino kj <Esc>
  cno jk <C-c>

  " Move visual block
  vn J :m '>+1<CR>gv=gv
  vn K :m '<-2<CR>gv=gv

  "Esc visual mode w/ return
  vn <CR> <Esc>

  "Remap 0 to toggle home position, use - for EOL
  nn 0 :call ToggleHomeZero()<CR>
  no - $

  "Fast saving/quiting
  nm <Leader>w :w!<CR>
  nm <Leader>Q :qa!<CR>
  nm <Leader>q :q<CR>

  "No typos on force quit
  cno Q q
  map q: :q

  "Smart way to move between windows
  nn <silent> <Leader>j <C-W>j
  nn <silent> <Leader>k <C-W>k
  nn <silent> <Leader>h <C-W>h
  nn <silent> <Leader>l <C-W>l

  "When you press <Leader>r you can search and replace the selected text
  vn <leader>r y:<C-u>%s/<C-R>"//gc<left><left><left>

  "Leader+r to do interactive find/replace regex
  nm <Leader>r :OverCommandLine <CR> %s/

  "Toggle white space display
  nm <Leader>ss :set list!<CR>
  set lcs=tab:▶\ ,eol:¬,extends:>,precedes:<
  let &showbreak='↪ '

  "Navigate Buffers with Space+(,|.)
  nn <Leader>, :bp<CR>
  nn <Leader>. :bn<CR>
  nn <Leader>0 :bl<CR>

  "Navigate Tabs with Space+t,(,|.)
  nn <Leader>t, :tabp<CR>
  nn <Leader>t. :tabn<CR>
  nn <Leader>t1 :tabn 1<CR>
  nn <Leader>t2 :tabn 2<CR>
  nn <Leader>t3 :tabn 3<CR>
  nn <Leader>t4 :tabn 4<CR>
  nn <Leader>t5 :tabn 5<CR>
  nn <Leader>t6 :tabn 6<CR>
  nn <Leader>t7 :tabn 7<CR>
  nn <Leader>t8 :tabn 8<CR>
  nn <Leader>t9 :tabn 9<CR>
  nn <Leader>t0 :tabn 10<CR>

  "Buffer kill
  nn <Leader>bq :bp<Bar>sp<Bar>bn<Bar>bd<CR>

  "Pressing <Leader>sp will toggle and untoggle spell checking
  nn <Leader>sp :setlocal spell!<CR>

  "Use paste mode with yo, yO, yi, yI, ya, yA
  nn <Leader>yp :set paste!<CR>
  nn <silent> yo  :set paste<CR>o
  nn <silent> yO  :set paste<CR>O
  nn <silent> yi  :set paste<CR>i
  nn <silent> yI  :set paste<CR>I
  nn <silent> ya  :set paste<CR>a
  nn <silent> yA  :set paste<CR>A

  "P will keep register contents
  vn P "_dP

  "Tab will jump to matched char
  nn <Tab> %
  vn <Tab> %
  map <Tab> %

  "Move <C-h>/<C-l> start/end for insert/commands
  ino <C-h> <ESC>I
  ino <C-l> <ESC>A
  cno <C-h> <HOME>
  cno <C-l> <END>
  cno <C-j> <S-Left>
  cno <C-k> <S-Right>

  "Quick scroll up/down w/ <Leader>+u/d
  nn <Leader>u <C-u>
  nn <Leader>d <C-d>

  "~ is operator like
  set tildeop

  "Map Diff Next/Prev to dn/dp
  nn dn ]c
  nn dN [c

  "Use dy to be consistent with y/p
  nn dy do

  "Skip folds with { & }
  nn <expr> } foldclosed(search('^$', 'Wn')) == -1 ? "}" : "}j}"
  nn <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? "{" : "{k{"
  " IGNORE: FIX FOR .vimrc SynHighlight: }

  "ENTER to get a command out
  map <Leader><CR> :

  " Source For Testing VimScript
  vn <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
  nn <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR> "

  "write in case didn't sudo
  cno w!! w !sudo tee % >/dev/null

  "Automatically source vimrc on save.
  au! bufwritepost $MYVIMRC source $MYVIMRC

  "Select just pasted text
  no gV `[v`]

  "Move text to left/right/center
  nn <Leader>.l :left<CR>
  nn <Leader>.r :right<CR>
  nn <Leader>.c :center<CR>
  vn <Leader>.l :left<CR>
  vn <Leader>.r :right<CR>
  vn <Leader>.c :center<CR>

  "Select indented line
  nn vv ^vg_

  "Visual Block with <Leader>+vb
  no <Leader>vb <C-v>

  "Horizontal split w/ C-w,h
  nn <C-w>h :split<CR>
  "Vertical split w/ C-w,v
  "nn <C-w>v :vsplit<CR>

  """"" Bash """""
  "Quick var ref
  au FileType sh ino vv $
  """"" Bash """""

  """"" PHP/Drupal """""
  "Quick object ref & array key/val assignment
  au FileType drush,php,module,inc,
    \install,test,profile,theme ino -- ->
  au FileType drush,php,module,inc,
    \install,test,profile,theme ino ;; ::
  au FileType drush,php,module,inc,
    \install,test,profile,theme ino -= =>

  "Quick var ref
  au FileType drush,php,module,inc,
    \install,js,test,profile,theme ino vv $

  "Quick PHP functions
  au FileType drush,php,module,inc,
    \install,test,profile,theme ino vd var_dump

  "Quick end statement
  nn <Leader>; A;<ESC>
  """"" PHP/Drupal """""

  """"" Markdown """""
  "  :<C-U>call <SID>opfunc(visualmode(),visualmode() ==# 'V' ? 1 : 0)<CR>
  "  :<C-U>call <SNR>89_opfunc(visualmode(),visualmode() ==# 'V' ? 1 : 0)<CR>

  " <Leader>+b = Wrap bold
  au FileType markdown vmap <buffer><silent><Leader>b S*vf*S*
  " <Leader>+c = Wrap code
  au FileType markdown vmap <buffer><silent><Leader>c S`
  " <Leader>+i = Wrap italic
  au FileType markdown vmap <buffer><silent><Leader>i S_
  " <Leader>+l = Wrap clipboard link
  au FileType markdown vmap <buffer><silent><Leader>l S]%a(<C-R>+)<ESC>
  " <Leader>+s = Wrap strikethrough
  au FileType markdown vmap <buffer><silent><Leader>s S~vf~S~
  """"" Markdown """""
augroup END

"""""""FORMATTING"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup FORMATTING
  "Cursor Position
  set ruler

  "Automatically remove trailing whitespace for certain files
  au FileType c,cpp,css,drush,inc,install,
    \html,java,js,module,php,pl,rb,sh,theme,test
    \ au BufWritePre <buffer> :%s/\s\+$//e

  "Set status line with file info
  set statusline=\ %{HasPaste()}%F%m%r%h%w
    \\ [FORMAT=%{&ff}]
    \\ [TYPE=%Y]
    \\ [ASCII=\%03.3b]
    \\ [HEX=\%02.2B]
    \\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
  set laststatus=2

  "Change Cursor With Mode
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  "Wildmenu
  set wildmenu
  set wildmode=list:longest,full

  "Ignore Some Items
  set wildignore+=.hg,.git,.svn                    " Version control
  set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
  set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
  set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
  set wildignore+=*.spl                            " compiled spelling list
  set wildignore+=*.sw?                            " Vim swap files
  set wildignore+=*.DS_Store                       " OSX bullshit
  set wildignore+=*.luac                           " Lua byte code
  set wildignore+=migrations                       " Django migrations
  set wildignore+=*.pyc                            " Python byte code
  set wildignore+=*.orig                           " Merge resolution files

  "Set line numbers
  set number
  nm <F2> :set number! number?<CR>
  set autoindent

  "Toggle relative line numbering
  nm <Leader><Leader>n :set invrelativenumber!<CR>
  set invrelativenumber

  "Tab = 2 spaces
  set expandtab
  set ts=2
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set backspace=2
  set smarttab
  set smartindent

  "Bracket formatting for new bloc
  ino {<CR> {<CR>}<ESC>O
  " FIX FOR SynHighlight: }

  "Round indentation to soft tab
  set shiftround

  "For regular expressions turn magic on
  set magic

  "Set utf8 as standard encoding and en_US as the standard language
  set encoding=utf8

  "Use Unix as the standard file type
  set ffs=unix,mac,dos

  " Enforce consistent line endings: if 'ff' is set to "unix" and there are
  " any " stray '\r' characters at ends of lines, then automatically remove
  " them. See  $VIMRUNTIME/indent/php.vim .
  let PHP_removeCRwhenUnix = 1

  ":FormatNewline = the Windows ^M - when the encodings gets messed up
  if !exists(":FormatNewline")
    command FormatNewline execute "normal mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm"
  endif

  ":FormatRetab = Retab document
  if !exists(":FormatTab")
    command FormatTab execute "retab <CR>"
  endif
augroup END

"""""""FUGITIVE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup FUGITIVE
  no <Leader>gs :Gstatus<CR>
  no <Leader>gd :Gdiff<CR>
  no <Leader>gc :Gcommit<CR>
  no <Leader>gb :Gblame<CR>
  no <Leader>gl :Glog<CR>
  no <Leader>gp :Git push<CR>
augroup END

"""""""HIGHLIGHTING"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup HIGHLIGHTING
  "File Type
  filetype plugin on

  "Syntax Highlighting
  syntax on

  "BaseLibs/SQL/HTML Highlighting
  let php_sql_query = 1
  let php_baselib = 1
  let php_htmlInStrings = 1

  "Keep selection highlighted through indentation shifting
  vm < <gv
  vm > >gv

  "Change highlight 
  nm <Leader>ch :set cursorcolumn!<CR>:set cursorline!<CR>

  "Highlight redundant whitespaces and tabs.
  highlight RedundantSpaces ctermbg=red guibg=red
  match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

  "Incremental search/nopaste/comment block
  set comments=sr:/*,mb:*,ex:*/

  "HTML/PHP/JS/CSS autocomplete
  au FileType css set omnifunc=csscomplete#CompleteCSS
  au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  au FileType js set omnifunc=javascriptcomplete#CompleteJS
  au FileType javascript
  \ setlocal omnifunc=javascriptcomplete#CompleteJS
  au FileType php setlocal omnifunc=phpcomplete#CompletePHP
  au FileType module setlocal omnifunc=phpcomplete#CompletePHP
  au FileType drush setlocal omnifunc=phpcomplete#CompletePHP
  au FileType theme setlocal omnifunc=phpcomplete#CompletePHP
  au FileType python setlocal omnifunc=pythoncomplete#Complete
  au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  "Drupal *.module and *.install files.
  au BufRead,BufNewFile *.module set filetype=php
  au BufRead,BufNewFile *.drush set filetype=php
  au BufRead,BufNewFile *.install set filetype=php
  au BufRead,BufNewFile *.theme set filetype=php
  au BufRead,BufNewFile *.test set filetype=php
  au BufRead,BufNewFile *.inc set filetype=php
  au BufRead,BufNewFile *.view set filetype=php

  "Highlight log messages
  au BufNewFile,BufReadPost *.log :set filetype=messages
  au BufNewFile,BufReadPost /var/log/* :set filetype=messages

  "Markdown Highlighting
  au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md
    \,README.txt
    \ :set filetype=markdown

  "Supresss errors
  au CursorMovedI * if pumvisible() == 0|pclose|endif
  au InsertLeave * if pumvisible() == 0|pclose|endif

  "Function Folding (Disable Autocomplete Performance)
  set nofoldenable

  "Folding for certain languages
  set foldmethod=indent
  set foldnestmax=2
  let javaScript_fold=1         " JavaScript
  let perl_fold=1               " Perl
  let php_folding = 0           " PHP
  let r_syntax_folding=1        " R
  let ruby_fold=1               " Ruby
  let vimsyn_folding='af'       " Vimscript
  let xml_syntax_folding=1      " XML

  "Use folding for .vimrc
  au BufNewFile,BufRead *.vimrc set foldenable

  "Use folding for .sh
  au BufNewFile,BufRead *.sh set foldmethod=marker
  au BufNewFile,BufRead *.sh set foldmarker={{{,}}}
  au BufNewFile,BufRead *.sh set foldenable

  "This fold is the one true king
  nn <Leader>zc zMzvzz

  "Turn off folding
  nn <Leader>zz :set nofoldenable!<CR>

  "Set PHP function folding
  nn <Leader>zp :EnablePHPFolds<CR>zM
  nn <Leader>zf :EnableFastPHPFolds<CR>zM

augroup END

""""""""BINARY""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup BINARY
    "Editing .bin files
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

"""""""MAC VIM""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MAC VIM
  "Set Nerd Fonts
  if has("gui_running")
    set guioptions=egmrt
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h10
  else
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 10
  endif
  "Set clipboard register
  set clipboard+=unnamed

  "Resize splits
  au VimResized * exe "normal! \<C-w>="
augroup END

"""""""POSITION"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup POSITION
  "When editing a file, always jump to the last cursor position
  au BufReadPost *
    \ if ! exists("g:leave_my_cursor_position_alone") |
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \ exe "normal g'\"" |
    \ endif |
    \ endif

  "Remember info about open buffers on close & 10 marks
  set viminfo^=%,'10,/10,:10

  "Jump 15 line at a time and scroll two lines before the end
  if !has('nvim')
    set scrolljump=20
  endif
  set scrolloff=5

  " Keep search matches in the middle of the window.
  nn n nzz
  nn N Nzz

  " Same when jumping around
  nn g; g;zz
  nn g, g,zz
  nn <C-o> <C-o>zz

  " Use H/L to get to BOL/EOL
  no H ^
  no L $
  vn L g_

  " Use <Leader> H/L to jump top/bottom
  no <Leader>H H
  no <Leader>L L

  "Add <> as matching pairs
  set matchpairs+=<:>
augroup END

"""""""QUICK EDITS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup QUICK EDITS
  nn <Leader>ev :vsplit $MYVIMRC<CR>
  nn <Leader>eb :vsplit ~/.bash_profile<CR>
  nn <Leader>eg :vsplit ~/.gitconfig<CR>
  nn <Leader>eh :vsplit /etc/hosts<CR>
  nn <Leader>es :vsplit ~/.ssh/config<CR>
  nn <Leader>ez :vsplit ~/.zshrc<CR>
augroup END

"""""""SEARCH"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup SEARCH
  "Ignore certain files
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

  "Highlight Search
  set hlsearch

  "Ignore case when searching
  set ignorecase

  "When searching try to be smart about cases
  set smartcase

  "Show included search
  set incsearch

  "Remove vim escaped regex chars
  nn / /\v\c
  vn / /\v\c

  " Visual mode pressing * or # searches for the current selection
  vn <silent> * y:/<C-R>"<CR>
  vn <silent> # y:?<C-R>"<CR>

  "LeaderjESC will toggle off search highlighting
  nn <Leader><ESC> :nohlsearch<CR>

  "Search from highlight mode
  vn * :<C-u>call <SID>VSetSearch()<CR>//<CR><C-o>
  vn # :<C-u>call <SID>VSetSearch()<CR>??<CR><C-o>

  "Search directory for instances of the current word
  no <Leader>#
    \ :execute "grep -r '" . expand("<cword>") . "' . " <Bar> cw<CR><CR>

  "Use Silver Searcher instead of grep
  if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
  endif

augroup END

"""""""SETTINGS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup SETTINGS

  "Set Backup Dir
  set backupdir =~/.vim/backup//
  set backup

  "Set Swap Dir
  set directory =~/.vim/swap//
  set noswapfile

  "Set Undo Dir
  silent! set undodir =~/.vim/undo//

  "Set Autoread
  set ar

  "Split below/right
  set splitbelow
  set splitright

  "Setting timeout length
  set ttimeout
  set ttimeoutlen=100

  "Show matching brackets when text indicator is over them
  set showmatch
  "How many tenths of a second to blink when matching brackets
  set mat=2

  "Show leader command active
  set showcmd

  "History length
  set history=5000

  "Keep buffer in memory after close.
  set hidden
augroup END

"""""""TABULARIZE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup TABULARIZE
  " https://devhints.io/tabular
  no <Leader>a= :Tabularize /=
  no <Leader>a: :Tabularize /:
  no <Leader>a:: :Tabularize /:\zs
  no <Leader>a, :Tabularize /,
  no <Leader>a<Bar> :Tabularize /
augroup END

"""""""TEMPLATES""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup TEMPLATES

  "For new files load a template
  au BufNewFile *.html 0r ~/.vim/templates/_.html

  au BufNewFile *.php 0r ~/.vim/templates/_.php
  au BufNewFile *.php :normal G

  au BufNewFile *.sh 0r ~/.vim/templates/_.sh
  au BufNewFile *.sh :normal G

augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""PLUGIN CONFIGURATIONS""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""TEMPLATE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup TEMPLATE

  augroup END

"""""""AIRLINE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup AIRLINE
    "Prettify
    let g:airline_powerline_fonts = 1
    let g:airline_theme='term'

    "Buffer lines
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#enabled = 1
    "let g:airline#extensions#tabline#left_sep = ' '
    "let g:airline#extensions#tabline#left_alt_sep = '|'

    "Custom whitespace checking
    let g:airline#extensions#whitespace#checks =
      \ ['indent', 'trailing', 'long']
    let g:airline#extensions#whitespace#trailing_format = 'trail[%s]'
    let g:airline#extensions#whitespace#mixed_indent_format = 'm-indent[%s]'
    let g:airline#extensions#whitespace#long_format = 'long[%s]'

    "Add Buffer Index
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    nm <leader>1 <Plug>AirlineSelectTab1
    nm <leader>2 <Plug>AirlineSelectTab2
    nm <leader>3 <Plug>AirlineSelectTab3
    nm <leader>4 <Plug>AirlineSelectTab4
    nm <leader>5 <Plug>AirlineSelectTab5
    nm <leader>6 <Plug>AirlineSelectTab6
    nm <leader>7 <Plug>AirlineSelectTab7
    nm <leader>8 <Plug>AirlineSelectTab8
    nm <leader>9 <Plug>AirlineSelectTab9

    "Short buffer stats +HEX
    let g:airline_section_z = '%3p%% %l:%c|0x%B'
  augroup END

"""""""AUTOCOMPLPOP"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup AUTOCOMPLPOP
    let g:acp_behaviorKeywordLength = 3

  augroup END

"""""""CLAM"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup CLAM
    "Bang your way to shell
    nn ! :Clam<space>
    vn ! :ClamVisual<space>
  augroup END

"""""""DRUPAL VIM""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup DRUPALVIM
    "Get selected variable val in Drush
    vn <Leader>dg
      \ :<BS><BS><BS><BS><BS>execute
      \ "Clam drush vget ".shellescape(expand("<cword>"), 1)<CR>
  augroup END

"""""""EASYMOTION"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup EASYMOTION
    "Add easymotion search
    map <Leader>f <Plug>(easymotion-sn)
    map <Leader>n <Plug>(easymotion-next)
    map <Leader>N <Plug>(easymotion-prev)

    "Add 2x leader easymotion directions
    map <Leader><Leader>l <Plug>(easymotion-lineforward)
    map <Leader><Leader>j <Plug>(easymotion-j)
    map <Leader><Leader>k <Plug>(easymotion-k)
    map <Leader><Leader>h <Plug>(easymotion-linebackward)

    "Repeat last motion
    map <Leader><Leader>s <Plug>(easymotion-repeat)

    " Require tpope/vim-repeat to enable dot repeat support
    " Jump to anywhere with only `s{char}{target}`
    " `s<CR>` repeat last find motion.
    nm <Leader>s <Plug>(easymotion-s2)

    "keep cursor column when JK motion
    let g:EasyMotion_startofline = 0
    " Use uppercase target labels and type as a lower case
    let g:EasyMotion_use_upper = 1
     " type `l` and match `l`&`L`
    let g:EasyMotion_smartcase = 1
    " Smartsign (type `3` and match `3`&`#`)
    let g:EasyMotion_use_smartsign_us = 1
  augroup END

"""""""EDITORCONFIG"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup EDITORCONFIG
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

  augroup END

"""""""FZF""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup FZF
    "Set filename search
    nn <Leader>o :Files<CR>

    "Set filebody search
    nn <Leader>O :F<CR>
    let g:rg_command = '
      \ rg --column --line-number --no-heading --fixed-strings --ignore-case
      \ --no-ignore --hidden --follow --color "always"
      \ -g "!{.git,node_modules,vendor}/*" '
    command! -bang -nargs=* F
      \ call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
  augroup END

"""""""GUTENTAGS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup GUTENTAGS
    "Specify cache dir in vim folder
    let g:gutentags_cache_dir = '~/.vim/gutentags'

    "let g:gutentags_exclude = ['*.css', '*.html', '*.js']

    " prevent gutentags from indexing the entire home directory
    " https://github.com/ludovicchabant/vim-gutentags/issues/13
    let s:notags = expand('~/.notags')
    if !filereadable(s:notags)
      call writefile([], s:notags)
    endif

  augroup END

"""""""HOPPING.VIM""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup HOPPING.VIM
    " Map to Leader+/
    nm <Space>/ <Plug>(hopping-start)

    " Keymapping
    let g:hopping#keymapping = {
    \	"\<C-n>" : "<Over>(hopping-next)",
    \	"\<C-p>" : "<Over>(hopping-prev)",
    \	"\<C-u>" : "<Over>(scroll-u)",
    \	"\<C-d>" : "<Over>(scroll-d)",
    \}

  augroup END

"""""""INTERSTINGWORDS""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup INTERSTINGWORDS
    nn <silent> <Leader>i :call InterestingWords('n')<CR>
    nn <silent> <Leader>I :call UncolorAllWords()<CR>

    let g:interestingWordsGUIColors = [
      \'134', '101', '211', '137', '214', '222']
  augroup END

"""""""NEOCOMPLCACHE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup NEOCOMPLCACHE
    "Enable
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

    " AutoComplPop like behavior.
    "let g:neocomplcache_enable_auto_select = 1

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_force_omni_patterns')
      let g:neocomplcache_force_omni_patterns = {}
    endif
    let g:neocomplcache_force_omni_patterns.php = '[^.  \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_force_omni_patterns.cpp =
      \'[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  augroup END

"""""""NERDCOMMENT""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup NERDCOMMENT

    "Give a shortcut key to NERDCOMMENT shortcut for PHPDocGen
    map <Leader>dg ,pd

  augroup END

"""""""NERDTREE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup NERDTREE
    "Give a shortcut key to NERD Tree map
    nm <Leader>ntt :NERDTreeToggle<CR>
    nm <Leader>ntf :NERDTreeFind<CR>

    "NERDTree open if no files / close if left / open on F4
    "au StdinReadPre * let s:std_in=1
    "au VimEnter *
      "\ if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    "au bufenter * if (winnr("$") == 1
      "\&& exists("b:NERDTreeType")
      "\&& b:NERDTreeType == "primary") | q | endif

    "Set NERDTree Options
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=[
      \'\\.pyc', '\\\~$', '\\.swo$', '\\.swp$',
      \'\\.git', '\\.hg', '\\.svn', '\\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
  augroup END

"""""""NRRWRGN""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup NRRWRGN
    nm <Leader>nw :NR<CR>
    vm <Leader>nw :NR<CR>
    let g:nrrw_topbot_leftright = 'botright'

  augroup END

"""""""PHPUnitQF""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup PHPUnitQF
    "<Leader>+tr fires PHPUnit test runner
    nm <Leader>tr :Test<CR>

  augroup END

"""""""PIV""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup PIV
    "Disable { for selected code
    "au! VimEnter * :vn <buffer> { {

    "Disable autofolding
    let g:DisableAutoPHPFolding = 1
  augroup END

"""""""SHOWMARKS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup SHOWMARKS
    "Highlight cursor & line
    nm <Leader>sm :ShowMarksToggle<CR>
      \ :set background=dark<CR> :colo solarized<CR>
      \ :highlight LineNr ctermfg=222<CR>

    " Don't leave on by default, use :ShowMarksOn to enable
    let g:showmarks_enable = 0
    let g:showmarks_include="abcdefghipqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    " For marks a-z
    highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Black
    " For marks A-Z
    highlight ShowMarksHLu gui=bold guibg=LightRed guifg=Black
    " For all other marks
    highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
    " For multiple marks on the same line.
    highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
  augroup END

"""""""SYNTASTIC""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup SYNTASTIC
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0

    let g:syntastic_html_tidy_ignore_errors=['proprietary attribute "ng-']

    let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
    let g:syntastic_php_phpcs_args = "
      \ --standard=Drupal
      \ --extensions=drush,php,module,inc,install,test,profile,theme,
      \js,css,info,txt,md"

    let g:syntastic_gitcommit_checkers = ['proselint']
    "let g:syntastic_javascript_checkers = ['eslint', 'json_tool', 'standard']
    let g:syntastic_javascript_checkers = ['standard', 'jsonlint']
    let g:syntastic_python_checkers = ['pylint']
    "let g:syntastic_python_pylint_args = '-s n'
    let g:syntastic_python_python_exec = 'python3'
    let g:syntastic_sh_checkers = ['shellcheck', 'sh']
    let g:syntastic_yaml_checkers = ['pyyaml']

    "More Significant Symbols
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '!'
    let g:syntastic_style_error_symbol = '✗§'
    let g:syntastic_style_warning_symbol = '!§'

    "Error options
    "let g:syntastic_debug = 3
    let g:syntastic_exit_checks = 0

    "Toggle off checkers by default.
    let g:loaded_syntastic_ansible_ansible_lint_checker = 0

    "Scroll through errors with ^ & v
    nm <silent> <UP> :lprev<CR>
    nm <silent> <DOWN> :lnext<CR>

    "Toggle display of Syntastic error window
    nn <silent> <Leader>e :<C-u>call ToggleErrors()<CR>
  augroup END

"""""""TAGBAR"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup TAGBAR
    nm <Leader>tt :TagbarToggle<CR>

    "TagBar-PHPCTags Options
    let g:tagbar_phpctags_memory_limit = '2G'
    "Compact tags
    let g:tagbar_compact = 1
  augroup END

"""""""UNDOTREE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup UNDOTREE
    "Leader+u Sets Undotree
    nn <Leader>U :UndotreeToggle<CR>
  augroup END

"""""""VIM-AUTOFORMAT"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup VIM-AUTOFORMAT
    "let g:formatterpath = ['/some/path/to/a/folder']
    "let g:autoformat_verbosemode=1
    nn <Leader>F :Autoformat<CR>
  augroup END

"""""""VIM-REPEAT"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup VIM-REPEAT
  augroup END

"""""""VIM-STICKY"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup VIM-STICKY
    let g:sticky_all = ['cursorcolumn', 'cursorline', 'list']

  augroup END

"""""""VIM-TERRAFORM""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup VIM-TERRAFORM
    " FMT / Align TF files automatically
    let g:terraform_fmt_on_save=1
    let g:terraform_align=1
  augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""HELPER FUNCTIONS"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""DISPLAY INFO ON COMMAND LINE"""""""""""""""""""""""""""""""""""""""""""
  function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
  endfunction

"""""""RETURNS TRUE IF PASTE MODE IS ENABLED""""""""""""""""""""""""""""""""""
  function! HasPaste()
    if &paste
      return 'PASTE MODE  '
    en
    return ''
  endfunction

"""""""DISABLES PASTE MODE WHEN LEAVING INSERT MODE"""""""""""""""""""""""""""
  augroup insertleave
    au InsertLeave *
      \ if &paste == 1 |
      \     set nopaste |
      \ endif
  augroup END


"""""""COPY THE CURRENT TEXT SELECTION TO THE SYSTEM CLIPBOARD""""""""""""""""
  augroup systemclip
    if has('gui_running')
      no <Leader>y "+y
    else
      " copy to attached terminal using the yank(1) script:
      " https://github.com/sunaku/home/blob/master/bin/yank
      no <silent> <Leader>y y
        \ :silent execute
        \   '!/bin/echo -n' shellescape(escape(@0, '\'), 1) '<Bar> yank'
        \ <Bar>redraw!<Return>
    endif
  augroup END

"""""""TOGGLE THE DISPLAY OF SYNTASTIC'S ERROR WINDOW"""""""""""""""""""""""""
  function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
      " Nothing was closed, open syntastic error location panel
      Errors
    endif
  endfunction

"""""""TOGGLE THE HOME POSITON""""""""""""""""""""""""""""""""""""""""""""""""
  "Credits to https://ddrscott.github.io/blog/2016/vim-toggle-movement/
  function! ToggleHomeZero()
    let pos = getpos('.')
    execute "normal! ^"
    if pos == getpos('.')
      execute "normal! 0"
    endif
  endfunction

"""""""VISUAL SEARCH""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup VISUAL SEARCH
    function! s:VSetSearch()
      let temp = @@
      norm! gvy
      let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
      let @@ = temp
    endfunction
  augroup END

"""""""COLORS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  augroup COLORS
    "Sample colors @ http://bytefluent.com/vivify/
    "Solarize VIM
    set background=dark
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    let g:solarized_degrade=1
    colorscheme solarized

    "Line Colors
    highlight LineNr ctermbg=236
    highlight LineNr ctermfg=222
    highlight LineNr gui=NONE guifg=DarkGrey guibg=NONE

    "Cursor Highlight Colors
    hi CursorLine  cterm=NONE ctermbg=234 ctermfg=253
    hi CursorColumn  cterm=NONE ctermbg=234 ctermfg=253

    " Mark 80 char boundary
    set colorcolumn=81

    "Set indent guides
    let g:indent_guides_auto_colors = 0
    if 'dark' == &background
      au VimEnter,Colorscheme *
        \ :hi IndentGuidesOdd  guibg=gray ctermbg=0
      au VimEnter,Colorscheme *
        \ :hi IndentGuidesEven guibg=green ctermbg=234
    else
      au VimEnter,Colorscheme *
        \ :hi IndentGuidesOdd  guibg=gray ctermbg=0
      au VimEnter,Colorscheme *
        \ :hi IndentGuidesEven guibg=green ctermbg=0
    endif

    "Clearer highlighting for diffs
    highlight DiffAdd
      \ cterm=bold ctermfg=10 ctermbg=22 gui=none guifg=bg guibg=Red
    highlight DiffDelete
      \ cterm=bold ctermfg=10 ctermbg=196 gui=none guifg=bg guibg=Red
    highlight DiffChange
      \ cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffText
      \ cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

    "autocomplete menu colors
    highlight Pmenu ctermfg=Black ctermbg=White
  augroup END

