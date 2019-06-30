"""""""VUNDLE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VUNDLE
  set nocompatible              " be iMproved, required
  filetype off                  " required

  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  " add fzf to runtime
  set rtp+=/usr/local/opt/fzf
  call vundle#begin()
  " alternatively, pass a path where Vundle should install plugins
  "call vundle#begin('~/some/path/here')

  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'

  """""""VIM PLUGINS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  Plugin 'beanworks/vim-phpfmt'
  Plugin 'bling/vim-airline'
  Plugin 'bootleq/ShowMarks'
  Plugin 'chr4/nginx.vim'
  Plugin 'chrisbra/NrrwRgn'
  Plugin 'editorconfig/editorconfig-vim'
  Plugin 'ernstwi/vim-sticky'
  Plugin 'ervandew/supertab'
  Plugin 'evidens/vim-twig'
  Plugin 'Glench/Vim-Jinja2-Syntax'
  Plugin 'godlygeek/tabular'
  Plugin 'groenewege/vim-less'
  Plugin 'itchyny/vim-cursorword'
  Plugin 'joonty/vdebug'
  Plugin 'junegunn/fzf.vim'
  "Doesn't work w/ +python3 vim
  "Plugin 'joonty/vim-phpunitqf'
  Plugin 'leafgarland/typescript-vim'
  Plugin 'ludovicchabant/vim-gutentags'
  Plugin 'majutsushi/tagbar'
  Plugin 'mbbill/undotree'
  Plugin 'myint/syntastic-extras'
  Plugin 'nathanaelkane/vim-indent-guides'
  Plugin 'osyo-manga/vim-hopping'
  Plugin 'osyo-manga/vim-over'
  Plugin 'pearofducks/ansible-vim'
  Plugin 'pangloss/vim-javascript'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'scrooloose/nerdcommenter'
  Plugin 'scrooloose/nerdtree'
  Plugin 'scrooloose/syntastic'
  Plugin 'Shougo/neocomplcache'
  Plugin 'sjl/clam.vim'
  Plugin 'spf13/PIV'
  Plugin 'ShawnConn/vim-colorschemes'
  Plugin 'StanAngeloff/php.vim'
  Plugin 'tmhedberg/matchit'
  Plugin 'Townk/vim-autoclose'
  Plugin 'tpope/vim-abolish'
  Plugin 'tpope/vim-fugitive'
  Plugin 'elzr/vim-json'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-surround'
  Plugin 'vasconcelloslf/vim-interestingwords'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'vim-php/tagbar-phpctags.vim'
  Plugin 'vim-scripts/sql.vim'
  Plugin 'vim-scripts/repmo.vim'
  Plugin 'wellle/targets.vim'
  Plugin 'wilywampa/vim-easymotion'
  Plugin 'https://git.drupal.org/project/vimrc.git', {'rtp': 'bundle/vim-plugin-for-drupal/'}

  "" The following are examples of different formats supported.
  "" Keep Plugin commands between vundle#begin/end.
  "" plugin on GitHub repo
  "Plugin 'tpope/vim-fugitive'
  "" plugin from http://vim-scripts.org/vim/scripts.html
  "" Plugin 'L9'
  "" Git plugin not hosted on GitHub
  "Plugin 'git://git.wincent.com/command-t.git'
  "" git repos on your local machine (i.e. when working on your own plugin)
  "Plugin 'file:///home/gmarik/path/to/plugin'
  "" The sparkup vim script is in a subdirectory of this repo called vim.
  "" Pass the path to set the runtimepath properly.
  "Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
  "" Install L9 and avoid a Naming conflict if you've already installed a
  "" different version somewhere else.
  "" Plugin 'ascenator/L9', {'name': 'newL9'}
  """""""VIM PLUGINS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " All of your Plugins must be added before the following line
  call vundle#end()            " required
  filetype plugin indent on    " required
  " To ignore plugin indent changes, instead use:
  "filetype plugin on
  "
  " Brief help
  " :PluginList       - lists configured plugins
  " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
  " :PluginSearch foo - searches for foo; append `!` to refresh local cache
  " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
  "
  " see :h vundle for more details or wiki for FAQ
  " Put your non-Plugin stuff after this line
augroup END
