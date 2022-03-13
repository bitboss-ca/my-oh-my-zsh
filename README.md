My Oh My ZSH
============

Requires
--------
Oh My ZSH: https://github.com/robbyrussell/oh-my-zsh

Screenshot
----------
![screenshot](https://raw.github.com/daveish/my-oh-my-zsh/master/screenshot.png)

Features
--------
- A simple way of separately maintaining themes for oh-my-zsh.
- Customize color palettes for themes.

Setup
-----

Clone the repo:
> git clone https://github.com/daveish/my-oh-my-zsh.git .my-oh-my-zsh

Add this to .zshrc (before the call to oh-my-zsh):
> source $HOME/.my-oh-my-zsh/my-oh-my-zsh.zsh

Set your theme to dave in .zshrc
> ZSH_THEME="dave" 

Link A Color Palette:
> cd .my-oh-my-zsh && ln -s dave.custom.hot-rod dave.custom

