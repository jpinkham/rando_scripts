#!/bin/bash

cd $HOME
mkdir -p bin
cd bin
ln --force -s ~/dev/openstack_stuff/vdi_things2install.sh .
ln --force -s ~/dev/openstack_stuff/update_repos.sh .
ln --force -s ~/dev/openstack_stuff/jq .
ln --force -s ~/dev/openstack_stuff/is_tmux_running.sh .
cd $HOME
echo "------------------------------------"
echo "Configuring favorite dotfiles..."
echo "------------------------------------"

# Using "-f" tests for regular file, not symlink
if [ -f .bashrc ];
then echo "Moving existing bashrc file"; cp .bashrc .bashrc.old; rm --force .bashrc
fi

if [ -f .bash_profile ];
then echo "Moving existing bash_profile file"; cp .bash_profile .bash_profile.old; rm --force .bash_profile
fi

if [ -f .bash_aliases ];
then echo "Moving existing bash_aliases file"; cp .bash_aliases .bash_aliases.old; rm --force .bash_aliases
fi

ln --force -s ~/dev/openstack_stuff/bashrc         .bashrc
ln --force -s ~/dev/openstack_stuff/bash_profile   .bash_profile
ln --force -s ~/dev/openstack_stuff/bash_aliases   .bash_aliases
ln --force -s ~/dev/openstack_stuff/vimrc          .vimrc
ln --force -s ~/dev/openstack_stuff/toprc          .toprc
ln --force -s ~/dev/openstack_stuff/tmux.conf       .tmux.conf
ln --force -s ~/dev/openstack_stuff/gitconfig       .gitconfig
# for hosts that aren't mine and only have screen instead of tmux
ln --force -s ~/dev/openstack_stuff/screenrc        .screenrc

# DO NOT SYMLINK OR COPY or you'll lose the authorized_keys entry from when you created the VM, and then you;ll be locked out
cat ~/dev/openstack_stuff/ssh_authorized_keys >> ~/.ssh/authorized_keys
cat ~/dev/openstack_stuff/ssh_config >> ~/.ssh/config

cp ~/dev/openstack_stuff/git-completion.bash $HOME/.
cp ~/dev/openstack_stuff/git-prompt.sh $HOME/.

echo "------------------------------------"
echo "Installing favorite apps..."
echo "------------------------------------"
sudo yum --assumeyes --skip-broken install unzip whois nmap docker python3.x86_64 mtr lynx telnet java-11-openjdk.x86_64 tree perl-Net-SSLeay nmap-ncat yum-cron nomachine.x86_64 tmux screen xfdesktop strace


echo "------------------------------------"
echo "Loading local docker images..."
echo "-------------------------------------"
# Install a Dockerized of sslscan that works how we were used to, because CentOS
# version is old and has totally different and hard to decipher output
sudo docker pull docker.vrsn.com/sslscan
##zcat $HOME/dev/openstack_stuff/docker_images/testssl_docker_image.gz | sudo docker load
sudo docker pull docker.vrsn.com/drwetter/testssl.sh

#https://github.com/sullo/nikto
sudo docker pull docker.vrsn.com/frapsoft/nikto

# Start up docker
echo "------------------------------------"
echo "Starting docker engine..."
echo "-------------------------------------"
sudo service docker start


echo "-------------------------------------"
echo "Configuring pip to use Artifactory"
mkdir -p $HOME/.pip
cp $HOME/dev/openstack_stuff/pip.conf $HOME/.pip/.

echo "Installing fav python apps..."
pip3 install --user bandit
pip3 install --user tmuxp
echo "-------------------------------------"


echo "-------------------------------------"
echo "To get Artifactory working for pip:"
echo "  - Copy netrc to $HOME/.netrc"
echo "  - Add password to $HOME/.netrc" 
echo "  - chmod 600 $HOME/.netrc"     
echo "-------------------------------------"

#load new bash rc and aliases
source $HOME/.bashrc

echo "-------------------------------------"
echo "Done!"
echo "------------------------------------"
