#!/bin/sh
ln -fs $(cd $(dirname $0) && pwd)/vimrc ~/.vimrc
ln -fs $(cd $(dirname $0) && pwd)/vimrc.orig ~/.vimrc.orig
ln -fs $(cd $(dirname $0) && pwd)/vimrc.emacs ~/.vimrc.emacs
ln -fs $(cd $(dirname $0) && pwd)/zshrc ~/.zshrc
ln -fs $(cd $(dirname $0) && pwd)/rubocop.yml ~/.rubocop.yml
