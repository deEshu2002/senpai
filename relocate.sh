#! /bin/bash


if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
    # Update package repositories
    echo "Updating package repositories..."
    sudo apt update && sudo apt upgrade -y

    # Just Conforming 
    # 1. curl 
    sudo apt install -y curl

    # Download the latest version of Git
    echo "Downloading Git..."
    sudo apt install -y git

    echo "Enter Github Name"
    read -r gName
    echo "Enter Github Name"
    read -r gEmail

    git config --global user.name "$gName"
    git config --global user.email "$gEmail"

    ssh-keygen -t ed25519 -C "gEmail"

    # Install Zsh
    echo "Downloading Zsh..."
    sudo apt install -y zsh

    # Set Zsh as the default shell
    chsh -s $(which zsh)

    # Install Oh My Zsh
    echo "Downloading OhMyZsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Generate the .zshrc file
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

    # Verify Zsh and Oh My Zsh installation
    echo "Zsh and Oh My Zsh installed successfully."
    echo "Current shell: $SHELL"

    # Clone fzf repository
    echo "Installing fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

    # Run the fzf installation script
    ~/.fzf/install --key-binding --completion --no-update-rc

    # Append fzf configurations to .zshrc
    echo "# fzf settings" >> ~/.zshrc
    echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> ~/.zshrc

    # Verify fzf installation
    echo "fzf installed successfully."

    # Install NVM (Node Version Manager)
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

    # Load NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  

    # Select NodeJs Version using fzf
    nvm install --lts

    # Install Neovim (nvim)
    echo "Installing Neovim (nvim)..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version

    # Optional: exposing nvim globally.
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

    # Install tmux
    echo "Installing tmux..."
    sudo apt install -y tmux 

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env

    cargo install typos-cli

    # Install ripgrep (rg)
    echo "Installing ripgrep (rg)..."
    cargo install ripgrep
    # sudo apt install -y ripgrep > /dev/null

    # Install bat
    echo "Installing bat..."
    cargo install --locked bat
    # sudo apt install -y bat > /dev/null


    # Installation of Docker
    sudo apt-get install ca-certificate curl gnupg

    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    sudo apt-get update

    sudo apt-get install docker-ce=5:24.0.2-1~ubuntu.22.04~jammy docker-ce-cli=5:24.0.2-1~ubuntu.22.04~jammy containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl enable --now docker

    sudo usermod -aG docker $USER
    newgrp docker

    # Installing Act
    echo "Installing Act(Used to deploy gh workflow locally..."
    curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

    # Installing FiraCode
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


    # Installing Go

    # 1. Define the desired Go version
    go_version="1.20" # Update this to the desired version

    # 2. Set the Go installation directory
    go_install_dir="/usr/local"

    # 3. Download the Go binary archive
    wget "https://golang.org/dl/go${go_version}.linux-amd64.tar.gz"

    # 4. Extract the archive
    tar -C "${go_install_dir}" -xzf "go${go_version}.linux-amd64.tar.gz"

    # 5. Set up the Go environment variables
    echo "export PATH=\$PATH:${go_install_dir}/go/bin" >> "${HOME}/.profile"
    echo "export GOPATH=\$HOME/go" >> "${HOME}/.profile"
    echo "export GOROOT=${go_install_dir}/go" >> "${HOME}/.profile"
    echo "export GO111MODULE=on" >> "${HOME}/.profile"
    source "${HOME}/.profile"

    # 7. Clean up the downloaded archive
    rm "go${go_version}.linux-amd64.tar.gz"

    echo "Go ${go_version} has been installed."


    # 2. Install Python and pip
    sudo apt install -y python3 python3-pip

    # 3. Install Conda
    conda_installer="Miniconda3-latest-Linux-x86_64.sh"
    wget "https://repo.anaconda.com/miniconda/${conda_installer}"
    bash "${conda_installer}" -b -p "$HOME/miniconda3"
    rm "${conda_installer}"

    # 4. Set up Conda environment variables
    echo "export PATH=\$HOME/miniconda3/bin:\$PATH" >> "$HOME/.zshrc"
    source "$HOME/.zshrc"

    echo "Python and Conda have been installed."


    # Chrome Download
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    # Chrome Install
    sudo dpkg -i google-chrome-stable_current_amd64.deb

    echo "ssh-key keys copied, now paste it in github"
    cat ~/.ssh/id_ed25519.pub

    mv fzf-shortcuts.sh ~/
    echo "source ~/fzf-shortcuts.sh" >> ~/.zshrc

    mv nvim ~/.config/

    dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-settings.txt
    
    echo "export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1'" >> ~/.fzf.zsh

    echo "export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'--color=fg:#d0d0d0,bg:#3a3a3a,hl:#668361 --color=fg+:#e4e4e4,bg+:#303030,hl+:#8eac89 --color=info:#bdbd79,prompt:#5f87af,pointer:#c62b60 --color=marker:#C56684,spinner:#afaf87,header:#87afaf'" >> ~/.fzf.zsh

fi
