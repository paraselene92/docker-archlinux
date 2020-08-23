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
  - git
  - iputils
  - jq
  - man
  - openssh
  - tig
  - unzip
  - vim

## Version

- v1.4
  - Install Starship (by dotfiles)

- v1.3
  - add `mirrorlist`file. For Arch linux repo.
  - Update Arch linux regularly.
