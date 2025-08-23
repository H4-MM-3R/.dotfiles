check_deps() {
    if ! command -v "$1" &> /dev/null; then
        echo "$1 is not installed"
        exit 1
    fi
}

lazygit_installed=$(check_deps "lazygit")
if [[ -z "$lazygit_installed" ]]; then
    echo "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
fi
echo "lazygit installed with version: $(lazygit --version)"
