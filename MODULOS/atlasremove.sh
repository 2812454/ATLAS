#!/bin/sh
username=$1
uuid=$2

if cat /etc/passwd |grep -w $user > /dev/null; then
echo ""
pkill -f "$username" > /dev/null 2>&1
deluser --force $username > /dev/null 2>&1
echo -e "\E[41;1;37m Usuario $username removido com sucesso! \E[0m"
grep -v ^$username[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
rm /etc/SSHPlus/senha/$username 1>/dev/null 2>/dev/null

fi     
[[ $(sed -n '/'${username}'/=' /etc/v2ray/config.json|head -1) ]] || invaliduuid
lineP=$(sed -n '/'${username}'/=' /etc/v2ray/config.json)
linePre=$(sed -n '/'${username}'/=' /etc/RegV2ray)
sed -i "${linePre}d" /etc/SSHPlus/RegV2ray
numl1=2
let resta=$lineP-$numl1
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
sed -i "${resta}d" /etc/v2ray/config.json
echo "  $username | $uuid  " >> /root/atlasremove.log
v2ray restart > /dev/null 2>&1
