# Setup
I use:
    * git init --bare $HOME/.myconf
    * alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
    * config config status.showUntrackedFiles no
where my ~/.myconf directory is a git bare repository. Then any file within the home folder can be versioned with normal commands like:
    * config status
    * config add .vimrc
    * config commit -m "Add vimrc"
    * config add .config/redshift.conf
    * config commit -m "Add redshift config"
    * config push

git clone --separate-git-dir=~/.myconf /path/to/repo ~

for more information: dotfiles.html

https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
https://news.ycombinator.com/item?id=11071754
