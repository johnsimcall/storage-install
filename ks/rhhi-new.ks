#liveimg --url=file:///tmp/squashfs
liveimg --url=http://nas/redhat-virtualization-host-4.3.5-20190920.0.el7_7.squashfs.img

lang en_US
keyboard us
timezone America/Denver --utc
rootpw --plaintext redhat1
network --device=link --bootproto=dhcp
%include /tmp/partitions
reboot


%pre   ### Setup liveimg from ISO/USB.  This section is not needed when installing from PXE
cd /tmp
rpm2cpio /run/install/repo/Packages/redhat-virtualization-host-image-update* | cpio -ivd
squashfs=$(find | grep squashfs | grep -v meta)
ln -s $squashfs /tmp/squashfs
%end

%pre   ### ERASE EVERYTHING!!!
INSTALL_LABEL="RHVH-4.3 RHVH.x86_64"
#INSTALL_LABEL="RHEL-7.7 Server.x86_64"

echo "DANGER -- Wiping all disks; except loopbacks, roms, and installaion media with label \"$INSTALL_LABEL\""
for i in $(lsblk --noheadings --nodeps --exclude 7,11 -o NAME); do
  THIS_LABEL=$(lsblk --noheadings --nodeps /dev/$i -o LABEL)
  [ "$THIS_LABEL" == "$INSTALL_LABEL" ] && echo "Skipping installation media on /dev/$i" && echo && continue
  echo "Wiping /dev/$i" && lsblk --nodeps /dev/$i -o +VENDOR,MODEL
  wipefs -af /dev/$i    && dd if=/dev/zero of=/dev/$i bs=1M count=100
  # mkswap is a desperate attempt to TRIM/discard if the device is SSD (really wish we had blkdiscard in anaconda...)
  mkswap /dev/$i && swapon -v --discard /dev/$i && swapoff -v /dev/$i && wipefs -af /dev/$i
done
%end

%pre   ### Create /tmp/partition file to %include later
#OSDISK=$(lsblk --noheadings --nodeps --output NAME,VENDOR,MODEL | awk '/INTEL SSD/ {print $1}')
OSDISK=$(lsblk --noheadings --nodeps --output NAME,VENDOR,MODEL | awk '/SanDisk/ {print $1}')

cat << EOF >> /tmp/partitions
zerombr
ignoredisk --only-use=$OSDISK
bootloader --boot-drive=$OSDISK --append="rd.luks.allow-discards console=ttyS0,115200 console=tty0"
clearpart  --all --initlabel --drives=$OSDISK
autopart --type=thinp --encrypted --passphrase=redhat2019
#part /boot     --fstype=xfs  --ondisk=$OSDISK --size=1024
#part /boot/efi --fstype=efi  --ondisk=$OSDISK --size=256  --fsoptions="umask=0077,shortname=winnt"
#part pv.01                   --ondisk=$OSDISK --size=71680 --encrypted --passphrase=redhat2019
#volgroup RHVH pv.01 --reserved-space 1024
#logvol none           --vgname=RHVH --thinpool    --size=1     --name=RHVHpool  --grow
#logvol swap           --vgname=RHVH --fstype=swap --size=1024  --name=swap                                     --fsoptions="defaults,discard"
#logvol /              --vgname=RHVH --fstype=xfs  --size=6144  --name=root          --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
#logvol /home          --vgname=RHVH --fstype=xfs  --size=1024  --name=home          --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
#logvol /tmp           --vgname=RHVH --fstype=xfs  --size=1024  --name=tmp           --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
#logvol /var           --vgname=RHVH --fstype=xfs  --size=22528 --name=var           --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
#logvol /var/crash     --vgname=RHVH --fstype=xfs  --size=10240 --name=var_crash     --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
#logvol /var/log       --vgname=RHVH --fstype=xfs  --size=10240 --name=var_log       --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
#logvol /var/log/audit --vgname=RHVH --fstype=xfs  --size=2048  --name=var_log_audit --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
### /var/tmp is for Harry CIS (needs to be big enough for rhvm-appliance extraction ~5GB)
#logvol /var/tmp       --vgname=RHVH --fstype=xfs  --size=5120  --name=var_tmp       --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
EOF
%end



### apply STIG and FIPS requirements
%addon org_fedora_oscap
        content-type = scap-security-guide
        profile = xccdf_org.ssgproject.content_profile_rhelh-vpp
%end



%post   ### Install the clevis RPMs and bind the LUKS device to Tang
yum-config-manager --add-repo "http://people.redhat.com/jcall/clevis"
curl -o /tmp/RPM-GPG-KEY-redhat-release "http://people.redhat.com/jcall/RPM-GPG-KEY-redhat-release"
rpm --import /tmp/RPM-GPG-KEY-redhat-release
yum -y install clevis-dracut clevis-systemd

# Find the device/partition supporting /
ROOTLV=$(findmnt -n -o SOURCE /)
ROOTVG=$(lvs --noheadings --options vg_name $ROOTLV)
ROOTPV=$(vgs --noheadings --options pv_name $ROOTVG)
ROOTLUKSDEV=$(cryptsetup status $ROOTPV | awk '/device:/ {print $2}')

luksmeta nuke -d $ROOTLUKSDEV -f
clevis luks bind -f -k- -d $ROOTLUKSDEV tang '{"url":"http://192.168.0.99:300","thp":"quMmeOB-MnJ39BKxzfkGrIMIoSs"}' <<< redhat2019
echo "Result of clevis-luks-bind was $?"

cat << EOF >> /etc/dracut.conf.d/clevis.conf
# Use DHCP on a specific interface, and don't create /etc/sysconfig/network-scripts/ifcfg-* files during boot
kernel_cmdline="ip=eno1:dhcp"
omit_dracutmodules+="ifcfg"
EOF

# Enable LVM discards (SSD TRIM)
sed -i.backup 's/issue_discards = 0/issue_discards = 1/' /etc/lvm/lvm.conf
%end



%post --erroronfail   ### This is required for RHV-H
cp /run/install/ks.cfg /root/ks.cfg
imgbase layout --init
%end
