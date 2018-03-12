""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""REMOVE PLUGIN MAPPING""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Remove Dir Uploading HSFTP
silent! unmap <leader>hsf

"Remove PIV surronding brackets
silent! vunmap <buffer> {

"Remap interstingwords and use only <leader>+k for window movement
if (index(pathogen_disabled, 'vim-interestingwords') < 0)
  nunmap <leader>k
  nunmap <leader>K
  nnoremap <silent> <leader>k <C-W>k
endif
