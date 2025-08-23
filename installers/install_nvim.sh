check_deps() {
    if ! command -v "$1" &> /dev/null; then
        echo "$1 is not installed"
        exit 1
    fi
}

nvim_installed=$(check_deps "nvim")
if [[ -z "$nvim_installed" ]]; then
    echo "Installing nvim..."
    git clone https://github.com/neovim/neovim.git ~/nvim
    cd ~/nvim || exit 1
    make CMAKE_BUILD_TYPE=Release
    sudo make install
fi
echo "nvim installed with version: $(nvim --version)"
