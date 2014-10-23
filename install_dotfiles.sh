#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s $DIR/.zshrc $HOME/.zshrc
ln -s $DIR/.profile $HOME/.profile
ln -s $DIR/.oh-my-zsh/themes/fragan.zsh-theme $HOME/.oh-my-zsh/themes/

git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/vundle
ln -s $DIR/.tmux.conf $HOME/.tmux.conf
ln -s $DIR/.vimrc $HOME/.vimrc
ln -s $DIR/vim/rcplugins $HOME/.vim/rcplugins

vim +BundleInstall &

sleep 380
kill -9 $(ps ax | grep 'vim +BundleInstall' | awk '{ print $1 }')

ln -s $DIR/vim/rcfiles $HOME/.vim/rcfiles
