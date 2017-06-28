 "------------------------
 "検索関係
 "------------------------
 set ignorecase          " 大文字小文字を区別しない
 set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
 set incsearch           " インクリメンタルサーチ
 set hlsearch             " 検索マッチテキストをハイライト

 " バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
 cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
 cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
 "
"------------------------
"編集関係
"------------------------
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set shiftwidth=2
set softtabstop=2
set expandtab
set cursorline          "カーソル行をハイライト
set noundofile
set display=lastline    "一行の文字数が多くてもきちんと描画する
set ambiwidth=double    " 全角記号を欠けないようにする
set encoding=utf-8
set fileencodings=utf-8,cp932
set pumheight=10 "補完メニューの高さ
set display=lastline "一行が長くても全ての文字を描画する

nnoremap + <C-a> "インクリメント
nnoremap - <C-x> "デクリメント

" カーソル後の文字削除
inoremap <silent> <C-d> <Del>
" 先頭、行末の移動
nnoremap <Space>h  ^
nnoremap <Space>l  $



 "---------------------------------------------
 " 改行
 " EmacsのC-oと同じ動作
 nnoremap go :<C-u>call append('.', '')<CR>

 " ↑の逆バージョン
 nnoremap gO :normal! O<ESC>j


 let mapleader = ","     "leaderを,に変更


 "インデントを連続して変更
 vnoremap < <gv
 vnoremap > >gv


 autocmd FileType * setlocal formatoptions-=ro "改行時にコメントが追加されるのを防ぐ


 " 対応括弧に'<'と'>'のペアを追加
 set matchpairs& matchpairs+=<:>

 " バックスペースでなんでも消せるようにする
 set backspace=indent,eol,start

 " クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
 " 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
 if has('unnamedplus')
     set clipboard& clipboard+=unnamedplus
 else
     " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
     set clipboard& clipboard+=unnamed
 endif

 " Swapファイル？Backupファイル？前時代的すぎ
 " なので全て無効化する
 set nowritebackup
 set nobackup
 set noswapfile
 set wildmenu  " コマンドライン補完を便利に


 "-------------------------
 "表示関係
 "-------------------------
"  set list                " 不可視文字の可視化
"  set listchars=tab:>-,eol:↲
 set number              " 行番号の表示
 set wrap                " 長いテキストの折り返し
 set textwidth=0         " 自動的に改行が入るのを無効化
 " set colorcolumn=80      " その代わり80文字目にラインを入れる

 "ビープ音すべてを無効にする
 set t_vb=
 set visualbell
 set novisualbell



  "--------------------------
  "マクロ及びキー設定
  "--------------------------

  " ESCを二回押すことでハイライトを消す
  nmap <silent> <Esc><Esc> :nohlsearch<CR>

  " カーソル下の単語を * で検索
  vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

  " 検索後にジャンプした際に検索単語を画面中央に持ってくる
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap * *zz
  nnoremap # #zz
  nnoremap g* g*zz
  nnoremap g# g#zz

  " j, k による移動を折り返されたテキストでも自然に振る舞うように変更
  nnoremap j gj
  nnoremap k gk

  " vを二回で行末まで選択
  vnoremap v $h
 "
  " Ctrl + hjkl でウィンドウ間を移動
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l



  " make, grep などのコマンド後に自動的にQuickFixを開く
  autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

  " QuickFixおよびHelpでは q でバッファを閉じる
  autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

  " w!! でスーパーユーザーとして保存（sudoが使える環境限定）
  cmap w!! w !sudo tee > /dev/null %

  " :e などでファイルを開く際にフォルダが存在しない場合は自動作成
  function! s:mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
          \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
  autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)
