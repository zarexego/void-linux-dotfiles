# Мой Void Linux + i3

Мои конфиги для Void Linux с i3, Polybar, Rofi, Neovim, Zapret и LightDM.

## Установка на новом ПК

1. Установи Void Linux, создай пользователя (желательно с именем `void`).
2. Установи git: `sudo xbps-install -S git wget unzip`
3. Клонируй репозиторий:
   ```bash
   git clone https://github.com/zarexego/void-linux-dotfiles
   cd ~/dotfiles

## Настройка драйверов видео

После установки нужно вручную определить GPU и поставить драйвер:

| GPU | Пакет | LIBVA_DRIVER_NAME |
|-----|-------|-------------------|
| Intel (Broadwell+, 2015+) | `intel-media-driver` | `iHD` |
| Intel (старый, до Broadwell) | `libva-intel-driver` | `i965` |
| AMD | `mesa-vulkan-radeon xf86-video-amdgpu` | `radeonsi` |
| NVIDIA | `nvidia` (проприетарный) | `nvidia` |

Затем добавь в `~/.local/bin/i3-session` перед `exec i3`:
```bash
export LIBVA_DRIVER_NAME=<твой_драйвер>
