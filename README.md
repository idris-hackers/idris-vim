Idris mode for vim
==================

This is an [Idris][] mode for vim which features syntax highlighting, indentation
and optional syntax checking via [Syntastic][]. If you need a REPL I recommend using
[Vimshell][].

![Screenshot](http://raichoo.github.io/images/vim.png)

## Installation

I recommend using [Pathogen][] for installation. Simply clone
this repo into your `~/.vim/bundle` directory and you are ready to go.

    cd ~/.vim/bundle
    git clone https://github.com/idris-hackers/idris-vim.git

### Manual Installation

Copy content into your `~/.vim` directory.

Be sure that the following lines are in your
`.vimrc`


    syntax on
    filetype on
    filetype plugin indent on


[Idris]: http://www.idris-lang.org
[Syntastic]: https://github.com/scrooloose/syntastic
[Vimshell]: https://github.com/Shougo/vimshell.vim
[Pathogen]: https://github.com/tpope/vim-pathogen
