url --url="http://rhclient4/rhel7/"
graphical
lang en_US.UTF-8
firstboot --disable
rootpw --plaintext redhat1
services --enabled="chronyd"
timezone America/New_York --isUtc
auth --enableshadow --passalgo=sha512
keyboard --vckeymap=us --xlayouts='us'
#network --hostname=rhdata6.dota-lab.iad.redhat.com
network --bootproto=dhcp --device=enp1s0f0 --noipv6 --activate
network --bootproto=dhcp --device=enp1s0f1 --noipv6 --activate
network --bootproto=dhcp --device=ens12f0  --noipv6 --activate
network --bootproto=dhcp --device=ens12f1  --noipv6 --activate
network --bootproto=dhcp --device=ens1f0   --noipv6 --activate
network --bootproto=dhcp --device=ens1f1   --noipv6 --activate
%include /tmp/part-include # this file is created in the %pre section
reboot


%packages
@^minimal
@core
chrony
kexec-tools
%end


%addon com_redhat_kdump --enable --reserve-mb='auto'
%end


%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end


%pre
#INSTALL_LABEL="RHVH-4.3 RHVH.x86_64"
INSTALL_LABEL="RHEL-7.7 Server.x86_64"

echo "DANGER -- Wiping all disks; except loopbacks, roms, and installaion media with label \"$INSTALL_LABEL\""
for i in $(lsblk --noheadings --nodeps --exclude 7,11 -o NAME); do
  THIS_LABEL=$(lsblk --noheadings --nodeps /dev/$i -o LABEL)
  [ "$THIS_LABEL" == "$INSTALL_LABEL" ] && echo "Skipping installation media on /dev/$i" && echo && continue
  echo "Wiping /dev/$i" && lsblk --nodeps /dev/$i -o +VENDOR,MODEL
  wipefs -af /dev/$i    && dd if=/dev/zero of=/dev/$i bs=1M count=100
  mkswap /dev/$i && swapon -v --discard /dev/$i && swapoff -v /dev/$i && wipefs -af /dev/$i  #this does a TRIM/discard
done

# Find our SSD by rotational=0 | filter major 7 (loops) and major 259 (NVMe)
SSD_ARRAY=($(lsblk --nodeps --exclude 7,259 --output rota,name --pair | tr --delete '"' | grep "ROTA=0" | cut --delimiter== --field=3))
if [ ${#SSD_ARRAY[*]} -ne 2 ]; then
  echo "ERROR: John Call's %pre script expected to find 2 SSD."
  echo "ERROR: Found ${#SSD_ARRAY[*]} instead."
  echo "ERROR: ${SSD_ARRAY[*]}"
  echo 'ERROR: Halting!'
  exit 1
fi
cat << EOF > /tmp/part-include
zerombr
clearpart  --all --initlabel --drives=${SSD_ARRAY[0]},${SSD_ARRAY[1]}
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=${SSD_ARRAY[0]}
part raid.101 --fstype="mdmember" --ondisk=${SSD_ARRAY[0]} --size=201
part raid.201 --fstype="mdmember" --ondisk=${SSD_ARRAY[1]} --size=201
part raid.102 --fstype="mdmember" --ondisk=${SSD_ARRAY[0]} --size=1025
part raid.202 --fstype="mdmember" --ondisk=${SSD_ARRAY[1]} --size=1025
part raid.103 --fstype="mdmember" --ondisk=${SSD_ARRAY[0]} --size=55328 --grow
part raid.203 --fstype="mdmember" --ondisk=${SSD_ARRAY[1]} --size=55328 --grow
raid /boot --device=boot --fstype="xfs" --level=RAID1 raid.102 raid.202
raid pv.1111 --device=pv00 --fstype="lvmpv" --level=RAID1 raid.103 raid.203
raid /boot/efi --device=boot_efi --fstype="efi" --level=RAID1 --fsoptions="umask=0077,shortname=winnt" raid.101 raid.201
volgroup rhelVG --pesize=4096 pv.1111
logvol / --fstype="xfs" --size=10396 --name=root --vgname=rhelVG --grow
logvol swap --fstype="swap" --size=4096 --name=swap --vgname=rhelVG
EOF
%end


%post
sed -i.backup 's/ rhgb quiet/ console=ttyS1,115200n8 console=tty0/g' /etc/default/grub
sed -i.backup 's/ rhgb quiet/ console=ttyS1,115200n8 console=tty0/g' /boot/efi/EFI/redhat/grub.cfg
yum -y install http://rhclient4/storcli.rpm
%end
