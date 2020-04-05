#!/bin/ash

filename=$1
user=$2
realm=$3
password=$4

digest="$( printf "%s:%s:%s" "$user" "$realm" "$password" | 
           md5sum | awk '{print $1}' )"

sed -i -e "/^$user:$realm:/ c$user:$realm:$digest" $filename
