#!/bin/sh
###############################################################################
# John Call hacked this up for RHVH from Frank's work at
# https://github.com/RedHatGov/ssg-el7-kickstart.git
#
# see also: https://access.redhat.com/solutions/1147263
###############################################################################

# USAGE STATEMENT
function usage() {
cat << EOF

Error!  Use this program to customize the Red Hat Virtualization Host (RHVH) ISO
        
usage: $0 RHVH-4.3-20190418.4-RHVH-x86_64-dvd1.iso

EOF
exit 1
}

# Check for correct arguments
if [[ $# -ne 1 ]]; then usage; exit 1; fi

# Check for root user, required to mount the ISO and install required tools
if [[ $EUID -ne 0 ]]; then
  tput setaf 1; echo -e "\033[1mPlease re-run this script as root!\033[0m"; tput sgr0; echo
  echo "root is required to mount the ISO and install required tools"
  echo "e.g. sudo $0 $@"
  exit 1
fi


echo "Make sure all tools (genisoimage, isomd5sum, syslinux) are installed..."
rpm -q genisoimage || yum install -y genisoimage
rpm -q isomd5sum || yum install -y isomd5sum
rpm -q syslinux || yum install -y syslinux 


echo "Checking for available disk space in /tmp"
volume_size=$(isoinfo -d -i /var/lib/libvirt/images/RHVH-4.3-20190418.4-RHVH-x86_64-dvd1.iso | awk '/Volume size/ {print $NF}')
block_size=$(isoinfo -d -i /var/lib/libvirt/images/RHVH-4.3-20190418.4-RHVH-x86_64-dvd1.iso | awk '/block size/ {print $NF}')
required_bytes=$(( volume_size * block_size ))
available_kilobytes=$(df --output=avail /tmp | awk '/^[0-9]/')
available_bytes=$(( available_kilobytes * 1024 ))
if [[ $required_bytes -gt $available_bytes  ]]; then
  tput setaf 1; echo -e "\033[1mNot enough free space in /tmp!\033[0m"; tput sgr0; echo
  echo "Need $required_bytes bytes"
  echo "Have $available_bytes bytes"
  exit 1
fi

echo "Checking for available disk space in output directory ($(pwd))"
OUTDIR=$(pwd)
OUTFILE=$(basename $1 | sed 's/.iso$/-NEW.iso/')
available_kilobytes=$(df --output=avail $OUTDIR | awk '/^[0-9]/')
available_bytes=$(( available_kilobytes * 1024 ))
if [[ $required_bytes -gt $available_bytes  ]]; then
  tput setaf 1; echo -e "\033[1mNot enough free space to create ISO at $OUTDIR!\033[0m"; tput sgr0; echo
  echo "Need $required_bytes bytes"
  echo "Have $available_bytes bytes"
  exit 1
fi

if [[ -e ${OUTDIR}/${OUTFILE} ]]; then 
  tput setaf 1; echo -e "\033[1mOutput file already exists at ${OUTDIR}/${OUTFILE}!\033[0m"; tput sgr0; echo
  exit 1
fi

echo "Mount ISO image..."
SOURCE=$(mktemp -d)
DEST=$(mktemp -d)
mount -o loop $1 $SOURCE


echo "Copying ISO contents..."
shopt -s dotglob
cp -av ${SOURCE}/* ${DEST}/
umount $SOURCE
rm -rv $SOURCE




echo "Installing custom kickstarts..."
cp -v  /home/jcall/Documents/storage-install/ks/rhhi.ks ${DEST}/dota.ks
cp -fv /home/jcall/Documents/storage-install/ks/usb-isolinux.cfg ${DEST}/isolinux/isolinux.cfg
cp -fv /home/jcall/Documents/storage-install/ks/usb-grub.cfg ${DEST}/EFI/BOOT/grub.cfg




echo "Remastering RHEL DVD Image..."
cd $DEST
# make boot image writeable, because `genisoimage` patches some layout data into it
chmod u+w isolinux/isolinux.bin
VOLNAME=$(isoinfo -d -i /var/lib/libvirt/images/RHVH-4.3-20190418.4-RHVH-x86_64-dvd1.iso | awk -F ': ' '/Volume id:/ {print $NF}')
genisoimage -R -J -T -m TRANS.TBL \
  -V "$VOLNAME" -o ${OUTDIR}/${OUTFILE} \
  -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table \
  -eltorito-alt-boot -e images/efiboot.img -no-emul-boot .

# make ISO bootable on UEFI systems
isohybrid --uefi ${OUTDIR}/${OUTFILE}

# Does this add the MD5SUM to the "-A" field of genisoimage?
# I don't think Red Hat supplies this in their official isos...
implantisomd5 ${OUTDIR}/${OUTFILE}

echo "Cleaning up..."
cd - &> /dev/null
rm -rf $DEST

echo "Created new ISO as ${OUTDIR}/${OUTFILE}"
exit 0


# Notes by John Call
# -J -- generate Joliet records, for Microsoft
# -R -- generate Rock Ridge records, for Linux (POSIX)
# -T -- generate translation tables (TRANS.TBL) for stuff older than Joliet and Rock Ridge
# -m TRANS.TBL -- exclude any TRANS.TBL files in the source tree from the output destination
# -V -- set the Volume ID !!!!!! This is referenced on the kernel cmdline to find the kickstart file !!!!!!!
# -o -- output file
#
# -b isolinux/isolinux.bin -- el torito boot image (in source tree)
# -c isolinux/boot.cat -- create this file/catalog (in source tree)
# -no-emul-boot -- ISOLINUX doesn't need HDD or FD emulation
# -boot-load-size 4 -- load 4*512bytes of the boot image during boot
# -boot-info-table -- patch/modify the isolinux.bin with 56 bytes of image layout
# 
# -eltorito-alt-boot -- 
# -e (-efi-boot) images/efiboot.img -- EFI boot file
# -no-emul-boot -- use it again, for EFI boot / "isohybrid" - https://wiki.syslinux.org/wiki/index.php?title=Isohybrid#UEFI
