#!/bin/bash
apt update
apt-get install -y wget
wget http://download.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
chmod +r /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" >>/etc/apt/sources.list
apt-get update
apt-get install -y git nano screen patch fakeroot build-essential devscripts
df -h
cd /home/build/pve-qemu
ls -la
mk-build-deps --install
make submodule
chmod +x sedPatch-pve-qemu-kvm7.0-8.1-anti-detection.sh
bash sedPatch-pve-qemu-kvm7.0-8.1-anti-detection.sh
useradd build -d /home/build/pve-qemu
chown -R build /home/build/pve-qemu
su - build -c "make deb"