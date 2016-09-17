# Basic development
sudo apt-get install -y vim git
mkdir -p ~/dev
cd ~/dev
if [ ! -d "config" ]; then
  git clone https://github.com/prosanes/config.git
fi
ln -s ~/dev/config/bashrc ~/.bashrc
ln -s ~/dev/config/vimrc ~/.vimrc
ln -s ~/dev/config/gitconfig ~/.gitconfig
ln -s ~/dev/config/git_template/ ~/.git_template/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qa

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# RbEnv
