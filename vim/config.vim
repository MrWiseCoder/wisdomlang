function _file_event(msg) abort
  echo "[EVENT] " . a:msg
endfunction

function _set_ft(msg) abort
  echo "ft=wisdom " . a:msg
  set ft=wisdom
endfunction

augroup wisdomgroup
  autocmd!
  autocmd filetype wisdom call _file_event("File type changed... ")
  autocmd BufRead *.wisdom call _set_ft("Buffer read => ")
  autocmd BufNewFile *.wisdom call _set_ft("New file => ")
augroup end


