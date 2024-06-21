#!/bin/bash
username=$1
password=$2
data=$3
hora=$4
sshlimiter=$5
uuid=$6

echo "  $username | $password | $data | $hora | $sshlimiter | $uuid  " >> /root/atlascreate.log

##ADICIONAR UTILIZADOR UUID

pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -e $data -M -s /bin/false -p $pass $username
echo "$password" > /etc/SSHPlus/senha/$username
echo "$username $sshlimiter" >> /root/usuarios.db


##ADDUSERV2RAY	
sed -i '13i\           \{' /etc/v2ray/config.json
sed -i '14i\           \"alterId": 0,' /etc/v2ray/config.json
sed -i '15i\           \"id": "'$uuid'",' /etc/v2ray/config.json
sed -i '16i\           \"ssh": "'$username'"' /etc/v2ray/config.json
sed -i '17i\           \},' /etc/v2ray/config.json

echo "  $uuid | $username | $password | $data | $hora " >> /etc/SSHPlus/RegV2ray

cp /etc/SSHPlus/RegV2ray /etc/SSHPlus/v2ray/RegV2ray-"$Fecha"
v2ray restart > /dev/null 2>&1

v2ray info > /etc/SSHPlus/v2ray/confuuid.log
lineP=$(sed -n '/'${uuid}'/=' /etc/SSHPlus/v2ray/confuuid.log)
numl1=4
let suma=$lineP+$numl1
sed -n ${suma}p /etc/SSHPlus/v2ray/confuuid.log 
sed -i "11 s;104.16.18.94%3A443;$username;g" /etc/SSHPlus/v2ray/confuuid.log
cat /etc/SSHPlus/v2ray/confuuid.log  | sed -n '11 p'
