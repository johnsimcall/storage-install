# A kicsktart to compare Clevis unlocking root, non-root simple (fs_on_luks), and non-root complex (LVM, VDO, etc...)
url --url="http://nas.home.lab/rhel7/"
graphical
auth --enableshadow --passalgo=sha512
keyboard --vckeymap=us --xlayouts='us'
lang en_US.UTF-8
rootpw redhat1
timezone America/Denver --isUtc
reboot

# Network information
network  --bootproto=dhcp --device=link

# Disk partitioning information
# Some partitions specify "_netdev" because I plan to unlock them via Clevis/Tang
# ^^^ Doesn't work because blivet removes _netdev from "non-network" disks https://bugzilla.redhat.com/show_bug.cgi?id=1722262
#autopart --type=lvm --nohome
ignoredisk --only-use=sda,sdb
clearpart  --all --initlabel --drives=sda,sdb
bootloader --append="console=ttyS0,115200 console=ttyS1,115200 console=tty0 crashkernel=auto"

part /boot     --fstype=ext4 --ondisk=sda --size=1024
part /boot/efi --fstype=efi  --ondisk=sda --size=256  --fsoptions="umask=0077,shortname=winnt"
part pv.01 --ondisk=sda  --size=35840 --encrypted --passphrase=redhat2019
volgroup RHEL pv.01 --reserved-space 1024
logvol none --vgname=RHEL --thinpool    --size=1     --name=RHELpool  --grow
logvol swap --vgname=RHEL --fstype=swap --size=1024  --name=swap
logvol /    --vgname=RHEL --fstype=xfs  --size=6144  --name=root      --poolname=RHELpool --thin --fsoptions="defaults,discard"
logvol /tmp --vgname=RHEL --fstype=xfs  --size=1024  --name=tmp       --poolname=RHELpool --thin --fsoptions="defaults,discard"
logvol /var --vgname=RHEL --fstype=xfs  --size=22528 --name=var       --poolname=RHELpool --thin --fsoptions="defaults,discard"

part /data --ondisk=sdb --size=10240 --encrypted --passphrase=redhat2020 --fstype=xfs --fsoptions="defaults,discard,_netdev"
part pv.02 --ondisk=sdb --size=10240 --encrypted --passphrase=redhat2021
volgroup HOME pv.02 --reserved-space 1024
logvol none  --vgname=HOME --thinpool    --size=1     --name=HOMEpool  --grow
logvol /home --vgname=HOME --fstype=xfs  --size=6144  --name=home      --poolname=HOMEpool --thin --fsoptions="defaults,discard,_netdev"



%packages
@^minimal
@core
chrony
kexec-tools
ipmitool
yum-utils
vim-enhanced
clevis-dracut
clevis-systemd
vdo
%end



%pre --erroronfail
### ERASE EVERYTHING!!! ###
#INSTALL_LABEL="RHVH-4.3 RHVH.x86_64"
INSTALL_LABEL="RHEL-7.7 Server.x86_64"

echo "DANGER -- Wiping all disks; except loopbacks, roms, and installaion media with label \"$INSTALL_LABEL\""
for i in $(lsblk --noheadings --nodeps --exclude 7,11 -o NAME,LABEL); do
  [ "$i" == "$INSTALL_LABEL" ] && echo "Skipping installation media on /dev/$i" && continue
  echo "Wiping /dev/$i" && lsblk --nodeps /dev/$i -o +VENDOR,MODEL
  wipefs -af /dev/$i    && dd if=/dev/zero of=/dev/$i bs=1M count=10 && echo
done
%end



%post
echo 'alias vi="vim"' >> /etc/skel/.bashrc
echo 'alias vi="vim"' >> /root/.bashrc

yum-config-manager --add-repo http://nas/rhel7
curl -o /root/RPM-GPG-KEY-redhat-release http://nas/rhel7/RPM-GPG-KEY-redhat-release
rpm --import /root/RPM-GPG-KEY-redhat-release

clevis luks bind -f -k- -d /dev/sda3 tang '{"url":"http://192.168.0.99:300","thp":"quMmeOB-MnJ39BKxzfkGrIMIoSs"}' <<< redhat2019
clevis luks bind -f -k- -d /dev/sdb2 tang '{"url":"http://192.168.0.99:300","thp":"quMmeOB-MnJ39BKxzfkGrIMIoSs"}' <<< redhat2020
clevis luks bind -f -k- -d /dev/sdb1 tang '{"url":"http://192.168.0.99:300","thp":"quMmeOB-MnJ39BKxzfkGrIMIoSs"}' <<< redhat2021

#yum -y install clevis-systemd
systemctl enable clevis-luks-askpass.path 

# FixUp /etc/crypttab: Put _netdev on non-root volumes
ROOT_LUKS=
for LUKS_VOL in $(awk '{print $1}' /etc/crypttab); do
  cryptsetup status $LUKS_VOL | grep "sda" && ROOT_LUKS=$LUKS_VOL && break
done
sed -E -e '/'$ROOT_LUKS'/!s:(.*):\1_netdev:' -i.backup /etc/crypttab

# FixUp /etc/fstab:  strip empty lines and comments, then restore _netdev option from kickstart
sed -E -e '/^$/d' -e '/^#.*/d' -i.backup /etc/fstab
# Find which partitions/logical volumes requested _netdev and put it there
# because blivet doesn't apply _netdev to non-network devices (BZ1722262)
for MOUNTPOINT in $(grep -E '^logvol.*_netdev|^part.*_netdev' /run/install/ks.cfg | awk '{print $2}'); do
  sed -E -e "s:(^\S+)(\s+)$MOUNTPOINT(\s+)(\S+)(\s+)(\S+)(\s+)([0-9]\s+[0-9]):\1  $MOUNTPOINT  \4  \6,_netdev  \8:" -i.backup /etc/fstab
done

# Rebuild the initramfs with the clevis module and updated /etc/crypttab /etc/fstab files... --assumes DHCP--
#yum -y install clevis-dracut
KVER=$(rpm -q kernel --qf "%{VERSION}-%{RELEASE}.%{ARCH}")
dracut -vf /boot/initramfs-$KVER.img $KVER
stat /boot/initramfs-$KVER.img > /root/initramfs-timestamp.txt
%end
