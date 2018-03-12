"""""""LUCIDITI .VIMRC""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""VUNDLE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VUNDLE
  set nocompatible              " be iMproved, required
  filetype off                  " required

  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  " alternatively, pass a path where Vundle should install plugins
  "call vundle#begin('~/some/path/here')

  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'

  """""""VIM PLUGINS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  Plugin 'ervandew/supertab'
  Plugin 'Townk/vim-autoclose'
  Plugin 'vim-scripts/repmo'
  Plugin 'joonty/vdebug'
  Plugin 'scrooloose/nerdcommenter'
  Plugin 'tpope/vim-surround'
  Plugin 'ShawnConn/vim-colorschemes'
  Plugin 'vim-scripts/sql'
  Plugin 'StanAngeloff/php'
  Plugin 'scrooloose/nerdtree'
  Plugin 'vim-scripts/ShowMarks'
  Plugin 'wilywampa/vim-easymotion'
  Plugin 'ctrlpvim/ctrlp'
  Plugin 'bling/vim-airline'
  Plugin 'nathanaelkane/vim-indent-guides'
  Plugin 'pangloss/vim-javascript'
  Plugin 'godlygeek/tabular'
  Plugin 'tpope/vim-abolish'
  Plugin 'tpope/vim-fugitive'
  Plugin 'chrisbra/NrrwRgn'
  Plugin 'sjl/clam'
  Plugin 'vasconcelloslf/vim-interestingwords'
  Plugin 'Shougo/neocomplcache'
  Plugin 'tmhedberg/matchit'
  Plugin 'mbbill/undotree'
  Plugin 'spf13/PIV'
  Plugin 'majutsushi/tagbar'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'tpope/vim-repeat'
  Plugin 'osyo-manga/vim-over'
  Plugin 'editorconfig/editorconfig-vim'
  Plugin 'evidens/vim-twig'
  Plugin 'scrooloose/syntastic'
  Plugin 'myint/syntastic-extras'
  Plugin 'joonty/vim-phpunitqf'
  Plugin 'ludovicchabant/vim-gutentags'
  Plugin 'vim-php/tagbar-phpctags'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'wellle/targets'
  Plugin 'leafgarland/typescript-vim'
  Plugin 'itchyny/vim-cursorword'
  Plugin 'Glench/Vim-Jinja2-Syntax'
  Plugin 'groenewege/vim-less'
  Plugin 'beanworks/vim-phpfmt'
  Plugin 'chr4/nginx.vim'

  "url = git://git.drupal.org/project/vimrc.git

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

