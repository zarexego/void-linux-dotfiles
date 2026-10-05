#!/bin/bash
set -e

USERNAME=$(whoami)
REPO_DIR=$(pwd)

echo "=== Установка dotfiles для $USERNAME ==="

# 1. Пакеты
echo "[1/7] Установка пакетов..."
sudo xbps-install -S $(cat packages.txt) || echo "Некоторые пакеты не установились, пропускаем."

# 2. Шрифты JetBrainsMono Nerd Font
echo "[2/7] Установка шрифтов..."
mkdir -p ~/.local/share/fonts/JetBrainsMono
if [ ! -f ~/.local/share/fonts/JetBrainsMono/JetBrainsMonoNerdFont-Regular.ttf ]; then
    wget -O /tmp/JetBrainsMono.zip \
      https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono/
    rm /tmp/JetBrainsMono.zip
fi
fc-cache -fv

# 3. Домашние конфиги
echo "[3/7] Копирование конфигов в домашнюю папку..."
cp -r home/. ~/

# 4. Системные файлы
echo "[4/7] Копирование системных файлов..."
sudo cp -r etc/. /etc/

# 5. Включение служб runit
echo "[5/7] Включение служб..."
for s in dbus lightdm nftables zapret pipewire wireplumber pipewire-pulse; do
    if [ -d /etc/sv/$s ] && [ ! -e /var/service/$s ]; then
        sudo ln -s /etc/sv/$s /var/service/
        echo "  - $s включена"
    fi
done

# 6. Замена имени пользователя (если отличается)
if [ "$USERNAME" != "void" ]; then
    echo "[6/7] Замена 'void' на '$USERNAME' в скриптах..."
    sed -i "s/void/$USERNAME/g" ~/.local/bin/i3-session 2>/dev/null || true
    sed -i "s/void/$USERNAME/g" ~/.xprofile 2>/dev/null || true
    sed -i "s/void/$USERNAME/g" /etc/sv/zapret/run 2>/dev/null || true
    sed -i "s/void/$USERNAME/g" /etc/sv/zapret/finish 2>/dev/null || true
fi

# 7. Права и финальные штрихи
echo "[7/7] Финальные штрихи..."
chmod +x ~/.local/bin/i3-session 2>/dev/null || true
chmod +x ~/zapret-discord-youtube-linux/*.sh 2>/dev/null || true

echo ""
echo "=== Готово! Перезагрузи систему: sudo reboot ==="
