#!/bin/ash

user=$1
realm=$2
password=$3

digest="$( printf "%s:%s:%s" "$user" "$realm" "$password" | 
           md5sum | awk '{print $1}' )"

printf "%s:%s:%s\n" "$user" "$realm" "$digest"
