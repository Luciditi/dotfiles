""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""REMOVE PLUGIN MAPPING""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Remove Dir Uploading HSFTP
silent! unmap <leader>hsf

"Remove PIV surronding brackets
silent! vunmap <buffer> {

"Remap interstingwords and use only <leader>+k for window movement
if !empty(glob("~/.vim/bundle/vim-interestingwords/plugin/interestingwords.vim"))
  nunmap <leader>k
  nunmap <leader>K
  nnoremap <silent> <leader>k <C-W>k
endif
