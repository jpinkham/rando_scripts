#!/bin/bash

cd $HOME
mkdir -p bin
cd bin
ln -f -s ~/dev/dotfiles/vdi_things2install.sh .
ln -f -s ~/dev/dotfiles/update_repos.sh .
ln -f -s ~/dev/dotfiles/is_tmux_running.sh .
cd $HOME
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


ln -f -s ~/dev/dotfiles/bashrc         .bashrc
ln -f -s ~/dev/dotfiles/bash_profile   .bash_profile
ln -f -s ~/dev/dotfiles/bash_aliases   .bash_aliases
ln -f -s ~/dev/dotfiles/bash_logout    .bash_logout
ln -f -s ~/dev/dotfiles/vimrc          .vimrc
ln -f -s ~/dev/dotfiles/toprc          .toprc
ln -f -s ~/dev/dotfiles/tmux.conf      .tmux.conf
ln -f -s ~/dev/dotfiles/gitconfig      .gitconfig

# DO NOT SYMLINK OR COPY or you'll lose the authorized_keys entry from when you created the VM, and then you;ll be locked out
##cat ~/dev/dotfiles/ssh_authorized_keys >> ~/.ssh/authorized_keys
cat ~/dev/dotfiles/ssh_config >> ~/.ssh/config

cp ~/dev/dotfiles/git-completion.bash $HOME/.
cp ~/dev/dotfiles/git-prompt.sh $HOME/.

echo "------------------------------------"
echo "Installing favorite apps..."
echo "------------------------------------"
#####sudo yum --assumeyes --skip-broken install unzip whois nmap docker python3.x86_64 mtr lynx telnet java-11-openjdk.x86_64 tree perl-Net-SSLeay nmap-ncat yum-cron nomachine.x86_64 tmux screen xfdesktop strace
## TODO: using $MACHINE_TYPE, create a mix of yum/apt/brew commands


echo "------------------------------------"
echo "Loading docker images..."
echo "-------------------------------------"
sudo docker pull docker.vrsn.com/drwetter/testssl.sh

#https://github.com/sullo/nikto
sudo docker pull docker.vrsn.com/frapsoft/nikto

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
source $HOME/.bashrc

echo "-------------------------------------"
echo "Done!"
echo "------------------------------------"
