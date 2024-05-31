#!/bin/sh

wget -qO rclone.conf https://gist.githubusercontent.com/Kkbrothers8795/a66614bf1ebfb54617eac16346e115cf/raw/d562b430a047c3a14e212eddbe36d364607e4024/rclone

triker listremotes --config rclone.conf \
    | while read line ; do echo "${line%:}"=$line ; done \
    | echo -e "\n[combine]\ntype = combine\nupstreams = $(tr "\n" " ")" >> rclone.conf

if [ -n "${USERNAME}" ] && [ -n "${PASSWORD}" ]; then

triker serve http combine: \
    --config=rclone.conf \
    --addr=:2029 \
    --user=$USERNAME \
    --pass=$PASSWORD \
    --buffer-size=64M \
    --template=dark.html \
    --vfs-cache-mode=full \
    --vfs-cache-max-age=1m0s

else

triker serve http combine: \
    --config=rclone.conf \
    --addr=:2029 \
    --buffer-size=64M \
    --template=dark.html \
    --vfs-cache-mode=full \
    --vfs-cache-max-age=1m0s

fi
