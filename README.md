# dotfiles

## Install

1. Install vim with lua

```bash
% sudo yum install -y gcc mercurial ncurses-devel make libgcc lua-devel perl-ExtUtils-Embed

% cd /usr/local/src/
% sudo hg clone https://bitbucket.org/vim-mirror/vim vim
% cd vim
% sudo hg pull
pulling from https://bitbucket.org/vim-mirror/vim
searching for changes
no changes found

% sudo ./configure --enable-multibyte --with-features=huge --enable-luainterp=yes --with-lua-prefix=/usr --enable-perlinterp --enable-pythoninterp --with-python-config-dir=/usr/lib64/python2.7/config  --enable-rubyinterp
% sudo make
% sudo make install
% rehash
% vim --version | grep lua
+dialog_con      +lua             +rightleft       +writebackup
```

2. clone dotfiles

```bash
% git clone --recursive https://github.com/hunya11/dotfiles.git
```

3. symbolic link

```bash
% ln -sf ~/dotfiles/.vimrc ~/.vimrc
% ln -sf ~/dotfiles/.vim ~/.vim
```

4. start up VIM

```bash
% vim
```

run ``:NeoBundleInstall`` and say **yes**.




