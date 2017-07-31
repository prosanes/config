# Basic development
sudo apt-get install -y vim git tmux i3 i3blocks arandr ctags pavucontrol
sudo add-apt-repository ppa:pgolm/the-silver-searcher
sudo apt-get update
sudo apt-get install silversearcher-ag
mkdir -p ~/dev
cd ~/dev
if [ ! -d "config" ]; then
  git clone https://github.com/prosanes/config.git
fi
mv ~/.bashrc ~/.bashrc.old
ln -s ~/dev/config/bashrc ~/.bashrc
ln -s ~/dev/config/vimrc ~/.vimrc
ln -s ~/dev/config/ideavimrc ~/.ideavimrc
ln -s ~/dev/config/gitconfig ~/.gitconfig
ln -s ~/dev/config/git_template ~/.git_template
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qa

# i3
mkdir ~/.i3
ln -s ~/dev/config/i3_config ~/.i3/config
ln -s ~/dev/config/i3blocks.conf ~/.i3blocks.conf

# Others
sudo apt-get install -y htop inotify-tools

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# Docker
sudo apt-get remove docker docker-engine
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo groupadd docker
sudo usermod -aG docker $USER

# Docker Compose
sudo sh -c 'curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose'
sudo chmod +x /usr/local/bin/docker-compose


# RbEnv
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
source ~/.bashrc
rbenv install 2.3.1
rbenv local 2.3.1

# Ripper-tags (ctags for ruby)
gem install ripper-tags gem-ctags
gem ctags

# Tags for ruby
mkdir -p ~/.rbenv/plugin
git clone git://github.com/tpope/rbenv-ctags.git ~/.rbenv/plugins/rbenv-ctags
rbenv ctags


# Java 8
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
