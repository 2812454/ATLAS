#!/bin/sh
username=$1
uuid=$2



invalid_username() {
        echo "USERNAME invÃƒÂ¡lido"
        exit 1
    }

_getUser() {
    user_count=$(grep "^$1:x:" /etc/passwd | cut -d ':' -f 1 | wc -c)
    echo $user_count | tr -dc '0-9'
}

if [ -z "${username}" ]; then
    echo "VocÃƒÂª deve especificar um usuÃƒÂ¡rio."
    exit 1
else
    user_count=$(_getUser $username)
    uuid_count=$(_getUser $uuid)
    if [ "$user_count" -gt 3 ]; then
        kill -9 $(ps -fu $username | awk '{print $2}' | grep -v PID)
        userdel $username
        echo "1"
        grep -v "^$username[[:space:]]" /root/usuarios.db > /tmp/ph
        cat /tmp/ph > /root/usuarios.db
        rm /etc/SSHPlus/senha/$username 1>/dev/null 2>/dev/null
        rm /etc/usuarios/$username 1>/dev/null 2>/dev/null
        
        grep -v "^$username[[:space:]]" /etc/SSHPlus/RegV2ray > /tmp/ph
        cat /tmp/ph > /etc/SSHPlus/RegV2ray
        
    else
        invalid_username
    fi
fi

delete_uuid() {
    if [ "$#" -ne 2 ]; then
        echo "Uso: $0 <uuid> <login>"
        exit 1
    fi


    invalid_uuid() {
        echo "UUID invÃƒÂ¡lido"
        exit 1
    }

    if grep -q "$uuid" /etc/v2ray/config.json; then
        tmpfile=$(mktemp)
        jq --arg uuid "$uuid" 'del(.inbounds[0].settings.clients[] | select(.id == $uuid))' /etc/v2ray/config.json > "$tmpfile" && mv "$tmpfile" /etc/v2ray/config.json

        sudo systemctl restart v2ray
        echo "Objeto com 'id' igual a $uuid removido"
    else
        invalid_uuid
    fi
}
echo "  $username | $uuid  " >> /root/atlasremove.log
delete_uuid "$username" "$uuid"
