#!/bin/sh
set -eu

systemctl --user enable --now hyprpolkitagent.service oo7-daemon.service
