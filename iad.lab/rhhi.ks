liveimg --url=http://rhclient4/rhvh.img
###timezone --utc

lang en_US
keyboard us
timezone America/New_York --utc
#auth --passalgo=sha512 --useshadow
rootpw --plaintext redhat1
network --device=link --bootproto=dhcp
#selinux --enforcing
#firewall --enabled --ssh --port=9090
#firstboot --disable

# From docs:  Minimum Total - 45 GB 
# If you use logvol --thinpool --grow, you must also include volgroup --reserved-space or volgroup --reserved-percent ... 
# https://access.redhat.com/documentation/en-us/red_hat_virtualization/4.2/html-single/installation_guide/#Storage_Requirements_RHV_install
zerombr
ignoredisk --only-use=sda
bootloader --boot-drive=sda
clearpart  --all --initlabel --drives=sda
part /boot     --fstype=ext4 --ondisk=sda --size=1024
part /boot/efi --fstype=efi  --ondisk=sda --size=256  --fsoptions="umask=0077,shortname=winnt"
part pv.01 --ondisk=sda  --size=46080
volgroup RHVH pv.01 --reserved-space 1024
logvol none           --vgname=RHVH --thinpool    --size=1     --name=RHVHpool  --grow
logvol swap           --vgname=RHVH --fstype=swap --size=1024  --name=swap
logvol /              --vgname=RHVH --fstype=xfs  --size=6144  --name=root      --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /tmp           --vgname=RHVH --fstype=xfs  --size=1024  --name=tmp       --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /home          --vgname=RHVH --fstype=xfs  --size=1024  --name=home      --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /var           --vgname=RHVH --fstype=xfs  --size=15360 --name=var       --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /var/log       --vgname=RHVH --fstype=xfs  --size=8192  --name=var_log   --poolname=RHVHpool --thin --fsoptions="defaults,discard" 
logvol /var/log/audit --vgname=RHVH --fstype=xfs  --size=2048  --name=var_audit --poolname=RHVHpool --thin --fsoptions="defaults,discard" 

reboot

%pre
echo "DANGER, wipeing all data"
for i in $(lsblk --noheadings --nodeps --exclude 7 -o NAME) ; do wipefs -af /dev/$i ; done
%end

%post --erroronfail
imgbase layout --init
%end
