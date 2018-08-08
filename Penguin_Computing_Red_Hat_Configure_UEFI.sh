#!/bin/bash
# Created by John Call (jcall@redhat.com)
# Tested to work with:
#   Penguin Computing Relion 2940 MH70-HD1-ZB-XX R08
#   Penguin Computing Relion 2900 MD90-FS0-ZB-XX R08
#   Penguin Computing Relion 1900 MD90-FS0-ZB-XX R08

# Suggest to "Load Defaults" before doing this

# /home/jcall/Documents/PenguinComputing/BIOS_AMIUtil_11302016/SceLnx_5_02_1097

SCE_UTIL=$(type -p SCELNX_64)
if [ -z $SCE_UTIL ]; then
  echo "ERROR: Can't find SCELNX_64 in any \$PATH"
  exit 1
fi

echo "CSM Support = DISABLE"
$SCE_UTIL /i /ms CSM004 /qv 0x00 && echo $?

echo "Boot option filter = UEFI only"
$SCE_UTIL /i /ms CSM005 /qv 0x02 && echo $?

echo "Network = UEFI"
$SCE_UTIL /i /ms CSM006 /qv 0x01 && echo $?

echo "Storage = UEFI"
$SCE_UTIL /i /ms CSM007 /qv 0x01 && echo $?

echo "Video = UEFI"
$SCE_UTIL /i /ms CSM008 /qv 0x01 && echo $?

echo "Other PCI devices = UEFI"
$SCE_UTIL /i /ms CSM009 /qv 0x01 && echo $?

echo "Network Stack = ENABLE"
$SCE_UTIL /i /ms NWSK000 /qv 0x01 && echo $?

echo "Quiet Boot = DISABLE"
$SCE_UTIL /i /ms SETUP005 /qv 0x00 && echo $?
