FROM archlinux/base:latest
ENV LANG="ja_JP.UTF8" \
  LC_TIME="ja_JP.UTF8" \
  TERM="xterm-256color"

COPY mirrorlist /tmp

RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen &&\
  locale-gen &&\
  ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime &&\
  cat /tmp/mirrorlist >> /etc/pacman.d/mirrorlist &&\
  #echo "Server = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/$repo/os/$arch" >> /etc/pacman.d/mirrorlist &&\
  pacman -Syu --noconfirm base-devel \
   docker \
   fish \
   fzf \
   git \
   iputils \
   jq \
   man \
   nodejs \
   npm \
   openssh \
   pacman-contrib \
   tig \
   tmux \
   unzip \
   vim \
   zip

RUN echo "[multilib]" >> /etc/pacman.conf &&\
  echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf &&\
  : "package list reload" &&\
  pacman -Syy &&\
  : "add user aur for yay" &&\
  : "add user work for work" &&\
  : "-m: make homedir, -r: create sys account, -s: target login shell" &&\
  useradd -m -r -s /bin/bash aur &&\
  useradd -m -s /usr/sbin/fish work &&\
  : "-d: delete passwd" &&\
  passwd -d aur &&\
  passwd -d work &&\
  : "bug workaround" &&\
  : "sudo: setrlimit(RLIMIT_CORE): 許可されていない操作です" &&\
  touch /etc/sudo.conf &&\
  echo "Set disable_coredump false" >> /etc/sudo.conf &&\
  : "if sudoers.d dir nothing, create dir" &&\
  mkdir -p /etc/sudoers.d &&\
  touch /etc/sudoers.d/aur &&\
  touch /etc/sudoers.d/work &&\
  echo 'aur ALL=(ALL) ALL' > /etc/sudoers.d/aur &&\
  echo 'work ALL=(ALL) ALL' > /etc/sudoers.d/work &&\
  chown -R aur:aur /home/aur &&\
  chown -R work:work /home/work &&\
  mkdir /build &&\
  chown -R aur:aur /build &&\
  usermod -aG docker work

WORKDIR /build
RUN sudo -u aur git clone https://aur.archlinux.org/yay.git
WORKDIR /build/yay
RUN sudo -u aur makepkg -si --noconfirm &&\
  sudo -u aur yay --afterclean --removemake --save
WORKDIR /root
RUN rm -rf /home/aur/.cache &&\
  rm -rf /build

RUN sudo -u aur yay -Syu --noconfirm git-secret
WORKDIR /home/work
RUN git clone --depth 1 https://github.com/paraselene92/dotfiles-docker-env.git dotfiles &&\
  chmod 777 dotfiles/install.sh &&\
  chown -R work:work dotfiles/

CMD ["/usr/sbin/fish"]
