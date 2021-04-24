#!/bin/bash

mkdir -p $HOME/bin
cd $HOME/bin || { echo "Could not change to directory >$HOME/bin<"; exit 1; }
ln -f -s ~/dev/rando_scripts/vdi_things2install.sh .
ln -f -s ~/dev/rando_scripts/update_repos.sh .
ln -f -s ~/dev/rando_scripts/is_tmux_running.sh .
ln -f -s ~/dev/rando_scripts/tail_syslog.sh .
cd $HOME || { echo "Could not change to directory >$HOME<"; exit 1; }
echo "------------------------------------"
echo "Configuring favorite dotfiles..."
echo "------------------------------------"

# Using "-f" tests for regular file, not symlink
if [ -f .bashrc ];
then echo "Moving existing bashrc file"; cp .bashrc .bashrc.old; rm -f .bashrc
fi

if [ -f .bash_profile ];
then echo "Moving existing bash_profile file"; cp .bash_profile .bash_profile.old; rm -f .bash_profile
fi

if [ -f .bash_aliases ];
then echo "Moving existing bash_aliases file"; cp .bash_aliases .bash_aliases.old; rm -f .bash_aliases
fi

if [ -f .bash_logout ];
then echo "Moving existing bash_logout file"; cp .bash_logout .bash_logout.old; rm -f .bash_logout
fi

if [ -f .gitconfig ];
then echo "Moving existing gitconfig file"; cp .gitconfig .gitconfig.old; rm -f .gitconfig
fi

if [ -f .vimrc ];
then echo "Moving existing vimrc file"; cp .vimrc .vimrc.old; rm -f .vimrc
fi

if [ -f .tmux.conf ];
then echo "Moving existing tmux.conf file"; cp .tmux.conf .tmux.conf.old; rm -f .tmux.conf
fi

echo "Symlinking config files"

ln -f -s ~/dev/dotfiles/bashrc-common  .bashrc
ln -f -s ~/dev/dotfiles/bash_profile   .bash_profile
ln -f -s ~/dev/dotfiles/bash_aliases   .bash_aliases
ln -f -s ~/dev/dotfiles/bash_logout    .bash_logout
ln -f -s ~/dev/dotfiles/vimrc          .vimrc
ln -f -s ~/dev/dotfiles/toprc          .toprc
ln -f -s ~/dev/dotfiles/tmux/tmux.conf .tmux.conf
ln -f -s ~/dev/dotfiles/gitconfig      .gitconfig

mkdir -p ~/.atom
echo "Symlinking Atom editor config files"
for ATOMFILE in config.cson github.cson init.coffee keymap.cson snippets.cson styles.less;
do
	ln -f -s ~/dev/dotfiles/atom/$ATOMFILE ~/.atom/$ATOMFILE
done;

#echo "Symlinking python config files"
#mkdir -p ~/.pip && ln -f -s ~/dev/dotfiles/python/pip.conf ~/.pip/.

echo "Symlinks complete"

# DO NOT SYMLINK OR COPY or you'll lose the authorized_keys entry from when you created the VM, and then you;ll be locked out
##cat ~/dev/dotfiles/ssh_authorized_keys >> ~/.ssh/authorized_keys
[ -d ~/.ssh ] && cat ~/dev/dotfiles/ssh_config >> ~/.ssh/config

cp ~/dev/dotfiles/git-completion.bash $HOME/.
cp ~/dev/dotfiles/git-prompt.sh $HOME/.

echo "------------------------------------"
echo "Installing favorite apps..."
echo "------------------------------------"
#####sudo yum --assumeyes --skip-broken install unzip whois nmap docker python3.x86_64 mtr lynx telnet java-11-openjdk.x86_64 tree perl-Net-SSLeay nmap-ncat yum-cron nomachine.x86_64 tmux screen xfdesktop strace
## TODO: using $MACHINE_TYPE, create a mix of yum/apt/brew commands
sudo apt install unzip whois docker.io python3 python3-pip mtr-tiny lynx telnet tree nmap nomachine tmux strace mlocate


echo "------------------------------------"
echo "Loading docker images..."
echo "-------------------------------------"
sudo docker pull drwetter/testssl.sh
sudo docker pull frapsoft/nikto
sudo docker pull knowl3dge/binwalk
#sudo docker pull 

# Start up docker
echo "------------------------------------"
echo "Starting docker engine..."
echo "-------------------------------------"
sudo service docker start


echo "-------------------------------------"
echo "Installing fav python apps..."
echo "-------------------------------------"
pip3 install --user bandit
pip3 install --user tmuxp


echo "-------------------------------------"
echo "Sourcing bash files..."
echo "------------------------------------"
#load new bash rc and aliases
# shellcheck source=/dev/null
source $HOME/.bashrc

echo "-------------------------------------"
echo "Done!"
echo "------------------------------------"
