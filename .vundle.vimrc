"""""VUNDLE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VUNDLE
  set nocompatible              " be iMproved, required
  filetype off                  " required

  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  " add fzf to runtime
  set rtp+=/usr/local/opt/fzf

  call vundle#begin()
  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'

  """""VIM PLUGINS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  Plugin 'aduros/ai.vim'
  Plugin 'bling/vim-airline'
  Plugin 'chiel92/vim-autoformat'
  Plugin 'chr4/nginx.vim'
  Plugin 'chrisbra/nrrwrgn'
  Plugin 'editorconfig/editorconfig-vim'
  Plugin 'ernstwi/vim-sticky'
  Plugin 'evidens/vim-twig'
  Plugin 'github/copilot.vim'
  Plugin 'glench/vim-jinja2-syntax'
  Plugin 'godlygeek/tabular'
  Plugin 'groenewege/vim-less'
  Plugin 'hashivim/vim-hashicorp-tools'
  Plugin 'itchyny/vim-cursorword'
  Plugin 'jelera/vim-javascript-syntax'
  if !has('nvim')
    Plugin 'joonty/vdebug'
    Plugin 'tabnine/YouCompleteMe'
  endif
  Plugin 'junegunn/fzf.vim'
  Plugin 'kkoomen/vim-doge'
  Plugin 'luciditi/vim-signature'
  Plugin 'leafgarland/typescript-vim'
  Plugin 'ludovicchabant/vim-gutentags'
  Plugin 'madox2/vim-ai'
  Plugin 'majutsushi/tagbar'
  Plugin 'mbbill/undotree'
  Plugin 'mtth/scratch.vim'
  Plugin 'mxw/vim-jsx'
  Plugin 'myint/syntastic-extras'
  Plugin 'osyo-manga/vim-hopping'
  Plugin 'osyo-manga/vim-over'
  Plugin 'pearofducks/ansible-vim'
  Plugin 'pangloss/vim-javascript'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'scrooloose/nerdcommenter'
  Plugin 'scrooloose/nerdtree'
  Plugin 'scrooloose/syntastic'
  Plugin 'sjl/clam.vim'
  Plugin 'shawnconn/vim-colorschemes'
  Plugin 'shawncplus/phpcomplete.vim'
  Plugin 'stanangeloff/php.vim'
  Plugin 'tmhedberg/matchit'
  Plugin 'townk/vim-autoclose'
  Plugin 'tpope/vim-abolish'
  Plugin 'tpope/vim-endwise'
  Plugin 'tpope/vim-fugitive'
  Plugin 'elzr/vim-json'
  Plugin 'terryma/vim-expand-region'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-surround'
  Plugin 'vasconcelloslf/vim-interestingwords'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'vim-php/tagbar-phpctags.vim'
  Plugin 'vim-scripts/sql.vim'
  Plugin 'vim-scripts/repmo.vim'
  Plugin 'tomlion/vim-solidity'
  Plugin 'wellle/targets.vim'
  Plugin 'wilywampa/vim-easymotion'
  Plugin 'yggdroot/indentline'
  Plugin 'zphere-zsh/shell-omni-completion'
  Plugin 'https://git.drupal.org/project/vimrc.git', {'rtp': 'bundle/vim-plugin-for-drupal/'}
  """""VIM PLUGINS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " All of your Plugins must be added before the following line
  call vundle#end()            " required
  filetype plugin indent on    " required
augroup END
