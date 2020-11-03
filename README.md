# docker-archlinux

This is "Archlinux container" for myself.

## Run

```console
docker pull paraselene92/archlinux:tagname
docker run -i -t --rm -w /home/work -u work -v (pwd):/home/work paraselene92/archlinux:tagname
```

tagname is optional. Default is `latest`. Tagname equals repository tag name(-v). In case repository tag name is "v1.0", tagname is "1.0".

## Description

- Using base image is `archlinux/base`.
- Using AUR helper is `yay`.
- Using default shell is `fish`.
- Clone from `dotfile` repository. You can install it in this container.

```console
cd /home/work/dotfiles
./install.sh
```

- Users
  - work: for work
  - aur: for yay install
- Installed packages
  - docker
  - fzf
  - git
  - iputils
  - jq
  - man
  - openssh
  - tig
  - tmux
  - unzip
  - vim

## Version
- v1.8
  - Update Arch linux regularly.

- v1.71
  - add `TERM="xterm-256color"`
  - fix tfenv settings

- v1.7
  - Install tmux
  - Install npm and nodejs (for terraform-lsp for coc-nvim)
  - Install tfenv (by dotfiles)
  - Install terraform-lsp (by dotfiles)
  - Update Arch linux regularly.
  - fix `dotfiles`dir permissions.

- v1.6
  - Install fzf
  - Install ghq (by dotfiles)
  - Update Arch linux regularly.

- v1.5
  - Update `.aws/*` secret files.
  - Update Arch linux regularly.

- v1.4
  - Install Starship (by dotfiles)

- v1.3
  - add `mirrorlist`file. For Arch linux repo.
  - Update Arch linux regularly.
