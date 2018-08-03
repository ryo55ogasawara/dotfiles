# dotfiles
##★使用方法
    git clone https://github.com/ryo55ogasawara/dotfiles.git
    cd dotfiles
    ./dotfilesLink.sh

##★修正方法(前設定)
    git config --global http.proxy http://[HTTPプロキシ]
    git config --global https.proxy https://[HTTPSプロキシ]
    git config --global user.name "[ユーザ名]"
    git config --global user.email "[メールアドレス]"
    git remote set-url origin https://ryo55ogasawara@github.com/ryo55ogasawara/dotfiles.git
    unset SSH_ASKPASS

##★修正方法
    git add [修正ファイル]
    git commit -m '[コメント]'
    git push origin master

---

##★変更履歴
###2018/07/06
* vim: ctagsに対応しました。
* vim: tab幅、インデント幅を統一しました。
* zsh: 履歴補完に対応しました。

###2018/06/03
* ruby静的解析「rubocop」の設定を追加しました。
* vim: テキストファイルは右端で折り返す設定にしました。

###2018/05/28
* vim: C言語のtab幅を4に変更しました。
* vim: rubyのみ、expandtab設定を追加しました。

###2017/10/02
* vimrc,zshrcを強化しました。
* vimrcを.origと.emacsに分離しました。
* 基本的な設定を.origに記載するようにしました。
* zshrcも環境に応じた定義を.mineファイルに記載できるようにしました。

###2017/09/23
* vimrc,zshrcを追加しました。
* dotfilesLink.shの実行により、ファイルが所定の位置にシンボリックリンクが張られます。
* zshをデフォルトにするには、chsh -s /bin/zsh コマンドを実行してください。

###2017/05/21
* 設定ファイルを本リポジトリに集約します。

