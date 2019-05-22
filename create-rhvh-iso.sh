#!/bin/sh
###############################################################################
# John Call hacked this up for RHVH from Frank's work at
# https://github.com/RedHatGov/ssg-el7-kickstart.git
#
# see also: https://access.redhat.com/solutions/1147263
###############################################################################

# GLOBAL VARIABLES
DIR=`pwd`

# USAGE STATEMENT
function usage() {
cat << EOF
usage: $0 rhel-server-7.X-x86_64-dvd.iso

SCAP Security Guide RHEL Kickstart RHEL 7.1+

Customizes a RHEL 7.1+ x86_64 Server or Workstation DVD to install
with the following hardening:

  - SCAP Security Guide (SSG) for Red Hat Enterprise Linux
  - Classification Banner (Graphical Desktop)

EOF
}

while getopts ":vhq" OPTION; do
	case $OPTION in
		h)
			usage
			exit 0
			;;
		?)
			echo "ERROR: Invalid Option Provided!"
			echo
			usage
			exit 1
			;;
	esac
done

# Check for root user
if [[ $EUID -ne 0 ]]; then
	if [ -z "$QUIET" ]; then
		echo
		tput setaf 1;echo -e "\033[1mPlease re-run this script as root!\033[0m";tput sgr0
	fi
	exit 1
fi

# Check for required packages
rpm -q genisoimage &> /dev/null
if [ $? -ne 0 ]; then
	yum install -y genisoimage
fi

rpm -q syslinux &> /dev/null
if [ $? -ne 0 ]; then
	yum install -y syslinux 
fi

rpm -q isomd5sum &> /dev/null
if [ $? -ne 0 ]; then
	yum install -y isomd5sum
fi

# Determine if DVD is Bootable
`file $1 | grep -q -e "9660.*boot" -e "x86 boot" -e "DOS/MBR boot"`
if [[ $? -eq 0 ]]; then
	echo "Mounting RHEL DVD Image..."
	mkdir -p /rhel
	mkdir $DIR/rhel-dvd
	mount -o loop $1 /rhel
	echo "Done."
	# Tests DVD for RHEL 7.4+
	if [ -e /rhel/.discinfo ]; then
		RHEL_VERSION=$(grep "Red Hat" /rhel/.discinfo | awk -F ' ' '{ print $5 }')
		MAJOR=$(echo $RHEL_VERSION | awk -F '.' '{ print $1 }')
		MINOR=$(echo $RHEL_VERSION | awk -F '.' -F ' ' '{ print $2 }')
		if [[ $MAJOR -ne 7 ]]; then
			echo "ERROR: Image is not RHEL 7.4+"
			umount /rhel
			rm -rf /rhel
			exit 1
		fi
		if [[ $MINOR -ge 4 ]]; then
			echo "ERROR: Image is not RHEL 7.4+"
			umount /rhel
			rm -rf /rhel
			exit 1
		fi
	else
		echo "ERROR: Image is not RHEL"
		exit 1
	fi

	echo -n "Copying RHEL DVD Image..."
	cp -a /rhel/* $DIR/rhel-dvd/
	cp -a /rhel/.discinfo $DIR/rhel-dvd/
	echo " Done."
	umount /rhel
	rm -rf /rhel
else
	echo "ERROR: ISO image is not bootable."
	exit 1
fi

echo -n "Modifying RHEL DVD Image..."
# Set RHEL Version in ISO Linux
sed -i "s/7.X/$RHEL_VERSION/g" $DIR/config/isolinux/isolinux.cfg
sed -i "s/7.X/$RHEL_VERSION/g" $DIR/config/EFI/BOOT/grub.cfg
cp -a $DIR/config/* $DIR/rhel-dvd/
if [[ $MINOR -ge 3 ]]; then
	rm -f $DIR/rhel-dvd/hardening/openscap*rpm 
fi
sed -i "s/$RHEL_VERSION/7.X/g" $DIR/config/isolinux/isolinux.cfg
sed -i "s/$RHEL_VERSION/7.X/g" $DIR/config/EFI/BOOT/grub.cfg
echo " Done."
echo "Remastering RHEL DVD Image..."
cd $DIR/rhel-dvd
chmod u+w isolinux/isolinux.bin

# Removing the TRANS.TBL files is unnecessary because we're masking them with `genisoimage -m TRANS.TBL ...`
find . -name TRANS.TBL -exec rm '{}' \; 

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

/usr/bin/mkisofs -J -T -V "RHEL-$RHEL_VERSION Server.x86_64" -o $DIR/ssg-rhel-$RHEL_VERSION.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -R -m TRANS.TBL .

cd $DIR
rm -rf $DIR/rhel-dvd
echo "Done."

echo "Signing RHEL DVD Image..."
/usr/bin/isohybrid --uefi $DIR/ssg-rhel-$RHEL_VERSION.iso &> /dev/null
/usr/bin/implantisomd5 $DIR/ssg-rhel-$RHEL_VERSION.iso
echo "Done."

echo "DVD Created. [ssg-rhel-$RHEL_VERSION.iso]"

exit 0
