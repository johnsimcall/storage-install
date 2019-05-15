# Assumes UEFI (/boot/efi) boot mode
liveimg --url=http://nas/redhat-virtualization-host-4.3-20190512.0.el7_6.squashfs.img

%pre
echo "DANGER, wipeing all data"
for i in $(lsblk --noheadings --nodeps --exclude 7 -o NAME); do
  wipefs -af /dev/$i
  dd if=/dev/zero of=/dev/$i bs=1M count=10
done
%end

lang en_US
keyboard us
timezone America/Denver --utc
rootpw --plaintext redhat1
network --device=link --bootproto=dhcp

# If you use logvol ... --thinpool --grow, you must also include volgroup --reserved-space OR volgroup --reserved-percent ... 
# From RHHI docs:  Minimum Total - 64 GB (64*1024=65536)
# https://access.redhat.com/documentation/en-us/red_hat_hyperconverged_infrastructure_for_virtualization/1.5/html-single/deploying_red_hat_hyperconverged_infrastructure_for_virtualization/index#rhhi-req-storage
zerombr
ignoredisk --only-use=sda
bootloader --boot-drive=sda
clearpart  --all --initlabel --drives=sda
part /boot     --fstype=ext4 --ondisk=sda --size=1024
part /boot/efi --fstype=efi  --ondisk=sda --size=256  --fsoptions="umask=0077,shortname=winnt"
part pv.01 --ondisk=sda  --size=68608
volgroup RHVH pv.01 --reserved-space 1024
logvol none           --vgname=RHVH --thinpool    --size=1     --name=RHVHpool  --grow
logvol swap           --vgname=RHVH --fstype=swap --size=1024  --name=swap
logvol /              --vgname=RHVH --fstype=xfs  --size=6144  --name=root      --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /tmp           --vgname=RHVH --fstype=xfs  --size=1024  --name=tmp       --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /home          --vgname=RHVH --fstype=xfs  --size=1024  --name=home      --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /var           --vgname=RHVH --fstype=xfs  --size=22528 --name=var       --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /var/crash     --vgname=RHVH --fstype=xfs  --size=10240 --name=var_crash --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /var/log       --vgname=RHVH --fstype=xfs  --size=22528 --name=var_log   --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /var/log/audit --vgname=RHVH --fstype=xfs  --size=2048  --name=var_audit --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
                                                  #TOTAL=69888 (68608 in PV/LVM + 1280 for /boot*)
reboot


%post --erroronfail
imgbase layout --init
%end
