#!/bin/bash

rhsvc_cleanup() {
for i in $@; do
  for j in enp1s0f1 ens4f0 ens4f1; do
    ssh -o "ControlMaster auto" -o "ControlPath /tmp/ssh-%r@%h:%p" $i \
      nmcli con del \"System $j\"
  done
  for j in lacp-data ens4f0-lacp-data ens4f1-lacp-data; do
    ssh -o "ControlMaster auto" -o "ControlPath /tmp/ssh-%r@%h:%p" $i \
      nmcli con del $j
  done
done
}

rhdata_cleanup () {
for i in $@; do
  for j in enp1s0f1 ens1f0 ens1f1 ens12f0 ens12f1; do
    ssh -o "ControlMaster auto" -o "ControlPath /tmp/ssh-%r@%h:%p" $i \
      nmcli con del \"System $j\"
  done
  for j in lacp-data ens1f0-lacp-data ens1f1-lacp-data lacp-priv ens12f0-lacp-priv ens12f1-lacp-priv; do
    ssh -o "ControlMaster auto" -o "ControlPath /tmp/ssh-%r@%h:%p" $i \
      nmcli con del $j
  done
done
}

make_bond() {
HOST=$1 ; NIC1=$2 ; NIC2=$3 ; BOND=$4 ; REALHOST=${HOST%%-*}
IPADDR=$(awk -v name=$HOST '$0~name {print $1}' /etc/hosts)
ssh -o "ControlMaster auto" -o "ControlPath /tmp/ssh-%r@%h:%p" $REALHOST \
  nmcli con add type bond \
  connection.interface-name $BOND \
  mode 802.3ad \
  connection.id $BOND \
  connection.autoconnect yes \
  connection.autoconnect-slaves 1 \
  ipv4.method static \
  ipv4.addresses $IPADDR/24 \
  ipv6.method ignore \
  802-3-ethernet.mtu 9216

ssh -o "ControlMaster auto" -o "ControlPath /tmp/ssh-%r@%h:%p" $REALHOST \
  nmcli con add type ethernet \
  connection.interface-name $NIC1 \
  master $BOND \
  connection.id $NIC1-$BOND \
  connection.autoconnect yes \
  802-3-ethernet.mtu 9216

ssh -o "ControlMaster auto" -o "ControlPath /tmp/ssh-%r@%h:%p" $REALHOST \
  nmcli con add type ethernet \
  connection.interface-name $NIC2 \
  master $BOND \
  connection.id $NIC2-$BOND \
  connection.autoconnect yes \
  802-3-ethernet.mtu 9216
}

echo ; echo "Begin"
rhsvc_cleanup rhsvc1 rhsvc2 rhsvc3 rhsvc4 rhsvc5
echo ; echo
rhdata_cleanup rhdata1 rhdata2 rhdata3 rhdata4 rhdata5 rhdata6

for i in rhsvc1-data rhsvc2-data rhsvc3-data rhsvc4-data rhsvc5-data; do
  make_bond $i ens4f0 ens4f1 lacp-data
done

for i in rhdata1-data rhdata2-data rhdata3-data rhdata4-data rhdata5-data rhdata6-data; do
  make_bond $i ens1f0 ens1f1 lacp-data
done

for i in rhdata1-priv rhdata2-priv rhdata3-priv rhdata4-priv rhdata5-priv rhdata6-priv; do
  make_bond $i ens12f0 ens12f1 lacp-priv
done

echo "Done" ; echo

# ------ #
# BACKUP #
# ------ #

# nmcli con add type bond ifname lacp-bond mode 802.3ad \
#  ...
#  +bond.options "xmit_hash_policy=layer2+3" \
#  +bond.options "miimon=100" \
#  ...
