" キャッシュディレクトリ
" F5 でキャッシュの更新ができる
  let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
" キャッシュを終了時に削除しない
  let g:ctrlp_clear_cache_on_exit = 0
" 遅延再描画
  let g:ctrlp_lazy_update = 1
" 無視するディレクトリ/ファイル
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '',
    \ 'file': '\v\.(exe|o)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
