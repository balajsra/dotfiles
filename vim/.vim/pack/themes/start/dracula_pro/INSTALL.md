### [Vim](http://www.vim.org/)

#### Install

These are the default instructions using Vim 8's `|packages|` feature.

1. Create theme folder (in case you don't have it yet):

- `\*nix` with Vim:

    ```bash
    # Vim 8.2+
    mkdir -p ~/.vim/pack/themes/start
    # Vim 8.0
    mkdir -p ~/.vim/pack/themes/opt
    ```

- `\*nix` with Neovim:

    ```bash
    nvim +'call mkdir(stdpath("data")."/site/pack/themes/start", "p")' +q
    ```

- Windows with Vim: create directory `$HOME\vimfiles\pack\themes\start` or
  `$HOME\vimfiles\pack\themes\opt`, according to your version.

2. Copy the `vim` folder and rename to "dracula_pro":

- `\*nix` with Vim:

    ```bash
    # change according to your version above
    cp -r vim ~/.vim/pack/themes/start/dracula_pro
    ```

- `\*nix` with Neovim:

    ```bash
    cp -R vim/ "$(nvim -es +"put =stdpath('data')" +print +'q!')"/site/pack/themes/start/dracula_pro
    ```

If these steps don't work in Neovim, then:
1. Launch Neovim
1. Write down the value of `:echo stdpath('data')`
1. In a shell:
    ```shell
    mkdir -p <stdpath_data>/site/pack/themes/start && cp -R vim/ <stdpath_data>/site/pack/themes/start/draucla_pro
    ```

#### Activate

1. Edit your vimrc file (`:help vimrc`):

- `\*nix` with Vim: edit `~/.vimrc` or `~/.vim/vimrc`
- `\*nix` with Neovim: edit `~/.config/nvim/init.vim`

- Windows with Vim: edit `$HOME\_vimrc` or `$HOME\vimfiles\vimrc`
- Windows with Neovim: edit `~/AppData/Local/nvim/init.vim`

with the following content

```
" For packages, versions 8.2 and later will autoload `start` packages
" correctly even in your vimrc.
if v:version < 802
    packadd! dracula_pro
endif
syntax enable
let g:dracula_colorterm = 0
colorscheme dracula_pro
```

P.S.: You need a 256-color or truecolor terminal and you may want one that
supports xterm sequences for :terminal.
