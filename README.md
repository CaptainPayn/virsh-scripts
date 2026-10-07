# some virsh stuffs
- adjust the kickstart script point to your iso and where you keep your qcow2's
- also need to create a ks.cfg file
## example ks.cfg file (change to your ssh key and password for rootpw)
```
# unattended install
cmdline
skipx

# system language and location
lang en_US.UTF-8
keyboard --vckeymap=us --xlayouts='us'
timezone America/New_York --utc

# network config
network --bootproto=dhcp --onboot=yes --activate

# disk partitioning
zerombr
clearpart --all --initlabel
autopart --type=plain

# root passwd & ssh
rootpw --plaintext password

%packages
@core
%end

%post
mkdir -p /root/.ssh
chmod 700 /root/.ssh
echo "<your-controller-public-ssh-key>" > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
%end

reboot --eject
```
