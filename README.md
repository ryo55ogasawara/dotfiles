# dotfiles
2017/05/21
設定ファイルを本リポジトリに集約します。

2017/09/23
vimrc,zshrcを追加しました。
dotfilesLink.shの実行により、ファイルが所定の位置に
シンボリックリンクが張られます。
zshをデフォルトにするには、chsh -s /bin/zsh
コマンドを実行してください。

2017/10/02
vimrc,zshrcを強化しました。
vimrcを.origと.emacsに分離しました。
基本的な設定を.origに記載するようにしました。
zshrcも環境に応じた定義を.mineファイルに記載できるようにしました。

★使用方法
git clone https://github.com/ryo55ogasawara/dotfiles.git
cd dotfiles
./dotfilesLink.sh

★修正方法(前設定)
git config --global http.proxy http://[HTTPプロキシ]
git config --global https.proxy https://[HTTPSプロキシ]
git config --global user.name "[ユーザ名]"
git config --global user.email "[メールアドレス]"

★修正方法
git add [修正ファイル]
git commit -m '[コメント]'
git push origin master

