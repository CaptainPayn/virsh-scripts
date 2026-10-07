#!/bin/bash
# unattended rocky install

if [[ "$EUID" -ne "0" ]]; then
        echo "This script must be ran with sudo"
        echo "Usage: sudo $0"
        exit 1
fi
read -p "Choose hostname for your vm: " VM_NAME

virt-install \
  --name="$VM_NAME" \
  --memory=2048 \
  --vcpus=2 \
  --disk path=/var/lib/libvirt/images/"$VM_NAME".qcow2,size=20 \
  --location=/mnt/storage/iso-images/Rocky-9.8-x86_64-minimal.iso \
  --initrd-inject=ks.cfg \
  --extra-args "inst.ks=file:/ks.cfg inst.cmdline hostname=$VM_NAME console=ttyS0,115200n8" \
  --os-variant rocky9 \
  --network network=default \
  --graphics none
