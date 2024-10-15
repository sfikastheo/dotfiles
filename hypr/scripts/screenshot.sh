#!/usr/bin/env bash
#  ____                               _           _
# / ___|  ___ _ __ ___  ___ _ __  ___| |__   ___ | |_
# \___ \ / __| '__/ _ \/ _ \ '_ \/ __| '_ \ / _ \| __|
#  ___) | (__| | |  __/  __/ | | \__ \ | | | (_) | |_
# |____/ \___|_|  \___|\___|_| |_|___/_| |_|\___/ \__|
#
#
# -----------------------------------------------------

DIR="$HOME/Pictures/screenshots/"
NAME="screenshot_$(date +%Y_%m_%d__%H_%M_%S)"
OUT_DIR="$HOME/Pictures/screenshots/$NAME"

grim -g "$(slurp)" - | gm convert - jpg:- | tee "$OUT_FILE" | wl-copy

