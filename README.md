pendulous-puppet
================

The Cloudatcost servers aren't very backupabble - no snapshotting and no access to the image. If you bork the install and/or lock yourself out, there is no recourse. So config management is critical.

This repo is a masterless puppet to make my pendulous.equipment in the cloud work. It assumes starting from the Debian 7 base.

__NOTE__ A cloudatcost 'reimage' assigns you a new static IP address and initial password. The IP address is not obtainable through DHCP - so if you've reimaged, you will have to change the existing network intefaces listed in this archive.


## Provisioning process

1. Reimage to the Debian 7 image using the cloudatcost console
1. Consider reinstalling using the 'netboot' image - see below list
1. Change /etc/apt/sources.list to something other than the clouadatcost defaults (the 'non-us' one doesn't even resolve).
1. aptitude update
1. aptitude install git puppet
1. git clone https://github.com/vacri/pendulous-puppet.git
1. edit network interface in puppet to match new IP address from reimaging 
1. cd pendulous-puppet && ./test && ./apply
1. grab a choccy milk



### Reimaging with debian netboot image
Note that's 'netboot' (13MB) not netinstall (~200MB), as the latter requires a CD or other mountable media

The netboot image is the amd64 'tiny cd' from https://www.debian.org/distrib/netinst

- Confirm that you could be arsed in the first place - it will take a while
- Take note of the IP address in the cloudatcost panel (panel.cloudatcost.com)
- Log into the machine
	su -
	wget http://ftp.nl.debian.org/debian/dists/wheezy/main/installer-amd64/current/images/netboot/netboot.tar.gz
	tar zxf netboot.tar.gz
	gunzip debian-installer/amd64/initrd.gz
	cp debian-installer/amd/initrd /boot/initrd.img-4-netboot
	cp debian-installer/amd/linux /boot/vmlinuz-4-netboot
	update-grub2
	reboot
- Back at the cloudatcost panel, click on 'console' for the relevant machine
- The popup window will show you the console, which should reboot into the Debian installer
- Follow the usual debian installer process as suits you
-- the network will not autoconfigure, you will have to use the IP address from the panel 
- This will end up with a Debian Stable installation, which can be upgraded again
	vi /etc/apt/sources.list  ->   %s/wheezy/jessie/g
	aptitude update
	aptitude install screen  ->  screen
	apt-get --download-only dist-upgrade     # have had problems with dist-upgrading in aptitude
	apt-get dist-upgrade
