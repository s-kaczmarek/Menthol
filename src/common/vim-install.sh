#!/bin/bash

sudo apt install -y vim

# TODO - install vim-pathogen (manager pakietów i wtyczek)
# Prawdopodobnie przwidłowym rozwiązaniem jest to opisane na stronie https://lukesmith.xyz/latex.html

# mkdir -p ~/.vim/autoload ~/.vim/bundle &&
# curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# TODO - mechanizm sprawdzający wpis w pliku .vimrc, czy pathogen jest aktywowany. W przypadku importu 
# dotfiles powinnien być aktywowany, jeśli ktoś go instaluje po praz pierwszy to warto automatycznie dopisać
# (zapytać usera najpierw - być może pathogen powinien być w osobnym skrypcie i wszystko zamknięte w agregat)

# execute pathogen#infect()
# syntax on
# filetype plugin indent on

# TODO - instalacja wtyczek dla vima:

## vim-live-latex-preview
#https://github.com/ying17zi/vim-live-latex-preview/