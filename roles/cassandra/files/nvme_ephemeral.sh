#!/bin/bash

if [[ ! -d /data]]; then
  mkdir /data
  mkfs.ext4 -m 0 /dev/nvme1n1
  mount -t ext4 -o noatime /dev/nvme1n1 /data
  echo "/dev/nvme1n1 /data ext4 noatime 0 0" | tee -a /etc/fstab
fi




