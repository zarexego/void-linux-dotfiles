#!/usr/bin/env bash
# Убиваем старые процессы polybar
killall -q polybar
# Ждём, пока они закроются
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# Запускаем polybar
polybar main -c ~/.config/polybar/config.ini &
