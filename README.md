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

## Features

Apart from syntax highlighting and indentation idris-vim offers some neat interactive
editing features. For more information on how to use it, read this blog article
by Edwin Brady on [Interactive Idris editing with vim][].

## Interactive Editing Commands

[Idris][] mode for vim offers interactive editing capabilities, the following
commands are supported.

`<LocalLeader>r` reload file
`<LocalLeader>t` show type
`<LocalLeader>d` add clause
`<LocalLeader>c` case split
`<LocalLeader>w` add with clause
`<LocalLeader>e` evaluate expression
`<LocalLeader>m` add missing clause
`<LocalLeader>p` proof search
`<LocalLeader>i` open idris response window


[Idris]: http://www.idris-lang.org
[Syntastic]: https://github.com/scrooloose/syntastic
[Vimshell]: https://github.com/Shougo/vimshell.vim
[Pathogen]: https://github.com/tpope/vim-pathogen
[Interactive Idris editing with vim]: http://edwinb.wordpress.com/2013/10/28/interactive-idris-editing-with-vim/

