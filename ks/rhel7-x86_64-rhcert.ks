# x86_64 Kickstart file for redhat-certification-hardware and RHEL 7
#
# This file prepares a system that can be used in two ways with the Red Hat 
# Hardware Certification program. The system can function as a system under 
# test (SUT), which is a system undergoing certification, or it can function 
# as a local test server (LTS), which is the command and control system 
# for certification activities. No configuration changes are required to 
# choose between these roles, the way in which you interact with the system
# determines its function. 
#
# For testers without a kickstart environment, here are the mandatory 
# configuration choices used in this file that you should select during 
# manual installation
# - English language installation 
# - Fresh install (no upgrades)
# - "Server with GUI" software selection
# - Appropriate partition layout:
#   - Recommended swap space size for hibernation (laptops) or general system 
#   function as described here: https://access.redhat.com/site/solutions/15244
#   - Swap space on bare metal (no LVM)
#   - Non-OS drives blank
# - All network devices set to use DHCP if not statically configured so that 
#   they can be tested
# - Firewall disabled
# - SELinux enabled
# - rhcertd service starting automatically at boot
# - All necessary redhat-certification packages and dependencies installed
# - All necessary debuginfo packages installed
# 
# Please see the "Kickstart Installations" section of the Red Hat Enterprise
# Linux 7 Installation Guide for more information on kickstart.
#
# https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/
#
# Begin redhat-certification kickstart file for RHEL 7 x86_64
install

# Remove the comment character "#" from ONE of the two lines below to choose 
# your install method and change the server information to match your own 
# environment.
#url --url http://myserver.mydomain.com/path/to/rhel7-x86_64/bits
#nfs --server=myserver.mydomain.com --dir=/path/to/rhel7-x86_64/bits

# Prevent the Setup Agent from running on first boot
firstboot --disable

# Choose the US keyboard layouts
keyboard --vckeymap=us --xlayouts='us'

# Choose the US English system language
lang en_US.UTF-8

# Configure the network connection(s)
network  --bootproto=dhcp --device=em1 --ipv6=auto --activate

# Disable the firewall
firewall --disable

# System authorization information
auth --enableshadow --passalgo=sha512

# Set the root password
rootpw redhat

# Enable SELinux (required for certification)
selinux --enforcing

# Set the system timezone
timezone America/New_York --isUtc

# Create a non-root user
user --name=certuser --password=redhat --gecos="Certification User"

# X Window System configuration information
xconfig  --startxonboot

# System bootloader configuration
bootloader --location=mbr --boot-drive=sda

# See the %pre section near the bottom of this file for partitioning 
%include /tmp/part-include

# Yum repository for redhat-certification, redhat-certification-backend, 
# redhat-certification-hardware, and dependencies python-django, 
# python-django-bash-completion, dt, lmbench, and stress.
# Change the next line to point to your custom rhcert package repository.
repo --name=rhcert --baseurl=http://myserver.mydomain.com/rhcert-rhel7-x86_64

# Yum repository for kernel debuginfo dependencies. Change the next line
# to point to your custom debuginfo repository.
repo --name=rhel7.2-x86_64-debug --baseurl=http://myserver.mydomain.com/rhel7.2-x86_64-debug

# Optional Yum repository for RHEL for Real Time packages. Uncomment the next
# line and change it to point to the Real Time install files if you wish to 
# certify for RHEL for Real Time 7.2.
#repo --name=Real_Time --baseurl=http://myserver.mydomain.com/path/to/RT/bits/

# Reboot when finished
reboot

%packages
@base
@core
@desktop-debugging
@fonts
@ftp-server
@gnome-desktop
@guest-agents
@guest-desktop-agents
@input-methods
@internet-browser
@multimedia
@x11
@virtualization-client
@virtualization-tools
@virtualization-hypervisor
@virtualization-platform
@web-server
# These are required packages for rhcert that aren't  
# dependencies resolved at system install time
kernel-debuginfo
kernel-tools
kernel-abi-whitelists
qemu-kvm-tools
dvd+rw-tools 
libvirt-python
oprofile
wodim
xterm
lftp
mcelog
mt-st
# Screen utility is helpful for running tests over an SSH session
# if debugging is necessary.
screen 
# Install rhcert and dependencies from our custom repository
redhat-certification
redhat-certification-hardware
redhat-certification-backend 
# Uncomment the following packages if you followed the optional steps
# above and want to certify for RHEL for Real Time.
#kernel-rt
#rt-setup
#rtctl
#rtcheck
#rteval
#rteval-common
#rteval-loads
#rt-tests
%end

%pre
#!/bin/sh
# Select the drives to use for install
# DO NOT USE THIS KICKSTART FILE ON A SYSTEM WITH DATA YOU WISH
# TO RETAIN! All drives are blanked by these commands.

echo "clearpart --all --initlabel" > /tmp/part-include
echo "ignoredisk --only-use=sda" >> /tmp/part-include
echo "part /boot --fstype="xfs" --size=512 --ondisk=sda" >> /tmp/part-include

# This swap section assumes that you have sufficient disk space to conform
# to the recommended swap sizes detailed in this Red Hat Knowledgebase
# article:  https://access.redhat.com/site/solutions/15244
# For laptops and anything else with a battery:
if udevadm info --export-db | grep -i -q bat[0-9]; then
   echo "part swap --hibernation --ondisk=sda" >> /tmp/part-include
# For all other systems:
else
   echo "part swap --recommended --ondisk=sda" >> /tmp/part-include
fi
# If your system doesn't have sufficient disk space, comment out the previous 
# if/else section and then uncomment and change the "--size" value on the 
# swap line below to an acceptable swap size for your system.
#echo "part swap --fstype="swap" --size=2048 --ondisk=sda" >> /tmp/part-include

echo "part / --fstype="xfs" --size=1024 --grow --ondisk=sda" >> /tmp/part-include
# If you are installing on a UEFI system, create an EFI partition.
if [ -d /sys/firmware/efi ]; then
   echo "part /boot/efi --fstype="efi" --size=200 --ondisk=sda" >> /tmp/part-include
fi
%end

%post
# Prevent the initial Gnome setup dialog box from
# appearing for root and the certuser.

mkdir /root/.config
echo "yes" > /root/.config/gnome-initial-setup-done

mkdir /home/certuser/.config
chown certuser:certuser /home/certuser/.config
echo "yes" > /home/certuser/.config/gnome-initial-setup-done
chown certuser:certuser /home/certuser/.config/gnome-initial-setup-done

# This line starts the listener and server functions
systemctl enable rhcertd

# If you are installing a local test server and you want to pull the
# pre-built virt guest down to the machine at install time, uncomment the
# following lines. A system under test will retrieve the pre-built guest
# from the local test server if present, which is much faster than retrieving
# the files from the FTP site.
#
# Note: RHEL 6 and 7 SUTs both use these files from the "RHEL7" directory.
#mkdir -p /var/www/rhcert/store/transfer/fv-images/RHEL7
#wget --directory-prefix=/var/www/rhcert/store/transfer/fv-images/RHEL7 ftp://partners.redhat.com/a166eabc5cf5df158922f9b06e5e7b21/hwcert/fv-images/RHEL7/hwcert-x86_64.img.tar.bz2
# Note: This next file fixes a RHEL 7.2 guest issue. It will be moved to
# the normal FTP site shortly, and this kickstart file will be updated.
#wget --directory-prefix=/var/www/rhcert/store/transfer/fv-images/RHEL7 http://people.redhat.com/gcase/rhcert-2/fv-images/hwcert-x86_64.xml.tar.bz2
#wget --directory-prefix=/var/www/rhcert/store/transfer/fv-images/RHEL7 ftp://partners.redhat.com/a166eabc5cf5df158922f9b06e5e7b21/hwcert/fv-images/RHEL7/hwcertData.img.tar.bz2

%end
# End rhcert-client kickstart file for RHEL 7 x86_64
#
# Changelog 
# 2017-10-04 Moved to systemd commands for service persistence
# 2017-06-22 Added a description of the choices in the kickstart file for
#            use with a manuall installation
# 2017-02-16 Replaced rhcert-backend command reference with new rhcertd
# 2017-01-19 Removed deprecated redhat-certification-information package
# 2015-11-20 Added temporary location for fv config file to fix 7.2 issue
# 2015-11-09 Added additional package requirement for redhat-certification-2.0 
# 2015-09-08 Removed the obsolete RHEL 6-specific guest file download section
# 2015-08-03 Added RHEL for Real Time sections
# 2015-06-08 Added swap partition automatic sizing
#            Added automatic /boot/efi partition creation
# 2015-05-20 Added lftp and mcelog
# 2015-03-04 Added firewall rules, updated local guest file directories
# 2015-02-07 Added guest file pull-down and server start commands
# 2015-02-06 Updated for new redhat-certification tool
# 2014-06-23 Updated for permanent location in .../released
# 2014-05-20 Updated for latest RC bits
# 2014-04-16 First version released
#
