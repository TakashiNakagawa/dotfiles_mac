if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

if has('win32')
  let g:vimproc#download_windows_dll = 1
endif

set rtp+=$HOME/.vim/
runtime! rc/*.vim
runtime! rc/plugins/*.vim

if has('kaoriya')
  let macvim_skip_colorscheme=1
endif
