#! /bin/bash
# TORUN: sudo bash relocate.sh

sudo apt update && sudo apt upgrade -y

# get git
sudo apt install git
git config --global user.name "Deeshu"
git config --global user.email "deepanshumehra2001@gmail.com"

# get zsh
sudo apt install -y zsh
# might not require -> chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# plugins(git fzf autocompletion)

# on restart set 0
# extentions, fzf completion function for git and completions and go path 

# get fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-bash --no-fish
source .zshrc

# get node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.zshrc
echo "Select package version"

nvm list-remote # finding using fzf
nvm install $SPECIFIED_NODE_VERSION

# get tldr
npm install -g tldr
# get pnpm
npm install -g pnpm

# setup github
  # create ssh key and add ot github
  # change default branch workflow

# get Typography (Fira, Input)
# for fira code -> 
fonts_dir="${HOME}/.local/share/fonts"
if [ ! -d "${fonts_dir}" ]; then
    echo "mkdir -p $fonts_dir"
    mkdir -p "${fonts_dir}"
else
    echo "Found fonts dir $fonts_dir"
fi

version=5.2
zip=Fira_Code_v${version}.zip
curl --fail --location --show-error https://github.com/tonsky/FiraCode/releases/download/${version}/${zip} --output ${zip}
unzip -o -q -d ${fonts_dir} ${zip}
rm ${zip}

echo "fc-cache -f"
fc-cache -f
# GET requrest for Input mono: https://input.djr.com/build/?fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do&email=

# get NVIM
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb

# export vscode settings

# export profile settings

# get docker
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# setup for go ?
curl -OL https://golang.org/dl/go1.20.4.linux-amd64.tar.gz
sha256sum go1.16.7.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz
# append export PATH=$PATH:/usr/local/go/bin to .profile

# setup for python
sudo apt install python3
sudo apt install -y python3-pip
sudo apt install build-essential libssl-dev libffi-dev python3-dev
sudo apt install -y python3-venv
python3 -m venv my_env
  # Activate Virtual Environment
  # source my_env/bin/activate
# Using python env
# python<version> -m venv <envname>

# get code

# get chrome
