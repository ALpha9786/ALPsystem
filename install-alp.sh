#!/bin/bash
echo "🧠 Installing ALPsystem — Lightweight .alp / .alppp compiler"
sleep 1

# Check package manager
if command -v apt >/dev/null 2>&1; then
    echo "Detected Debian/Ubuntu"
    sudo apt update
    sudo apt install -y gcc g++ git nano
elif command -v dnf >/dev/null 2>&1; then
    echo "Detected Fedora/RHEL"
    sudo dnf install -y gcc-c++ nano git
elif command -v pacman >/dev/null 2>&1; then
    echo "Detected Arch/Manjaro"
    sudo pacman -S --needed --noconfirm gcc nano git
else
    echo "❌ Unsupported distro"
    exit 1
fi

# Clone ALPsystem
cd ~
if [ -d "$HOME/ALPsystem" ]; then
    echo "📦 Updating existing ALPsystem..."
    cd ALPsystem && git pull
else
    echo "📥 Cloning ALPsystem..."
    git clone https://github.com/ALpha9786/ALPsystem.git
fi

# Add to PATH
if ! grep -q 'ALPsystem/bin' ~/.bashrc; then
    echo 'export PATH="$HOME/ALPsystem/bin:$PATH"' >> ~/.bashrc
    echo "✅ Added ALPsystem to PATH"
fi

# Apply changes
source ~/.bashrc
hash -r

echo "✅ Installation Complete!"
echo "Test with: alpc hello.alp or ALPcheck --version"
