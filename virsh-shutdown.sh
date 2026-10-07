#!/bin/bash

if [[ "$EUID" -ne "0" ]]; then
        echo "This script must be ran with sudo"
	echo "Usage: sudo $0"
        exit 1
fi

for i in $(virsh list --name); do
	virsh shutdown "$i"
done
echo "=== Shutdown initiated ==="
