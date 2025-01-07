#!/usr/bin/env bash

# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y sudo
$STD apt-get install -y mc
$STD apt-get install -y git
$STD apt-get install -y wget
$STD apt-get install -y dpkg-dev
$STD apt-get install -y openssh-server
msg_ok "Installed Dependencies"

msg_info "Installing Proxmox Backup Server"
$STD apt-get update
export DEBIAN_FRONTEND=noninteractive
git clone https://github.com/wofferl/proxmox-backup-arm64
cd ./proxmox-backup-arm64
./build.sh download
apt install -y -f ./packages/*
msg_ok "Installed Proxmox Backup Server"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
