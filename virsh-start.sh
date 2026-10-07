#!/bin/bash

if [[ "$EUID" -ne "0" ]]; then
    echo "This script must be ran with sudo"
    echo "Usage: sudo $0"
    exit 1
fi

virsh list --name --state-shutoff | grep -v '^$' | while read -r vm; do
    echo "Starting $vm..."
    virsh start "$vm"
    
    # Verify execution output before sleeping
    if [[ $? -eq 0 ]]; then
        echo "Successfully started $vm. Waiting 15 seconds..."
        sleep 15
    else
        echo "Failed to start $vm."
    fi
done
