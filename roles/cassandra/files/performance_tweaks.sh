#!/bin/bash

# Copyright (c) 2014 Lekane Oy. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#    * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#    * Neither the name of Lekane Oy nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

echo "cassandra - memlock unlimited" >> /etc/security/limits.conf
echo "cassandra - nofile 100000" >> /etc/security/limits.conf
echo "cassandra - nproc 32768" >> /etc/security/limits.conf
echo "cassandra - as unlimited" >> /etc/security/limits.conf
echo "* hard    nofile  65532" >> /etc/security/limits.conf
echo "* soft    nofile  65532" >> /etc/security/limits.conf
echo "root - memlock unlimited" >> /etc/security/limits.conf
echo "root - nofile 100000" >> /etc/security/limits.conf
echo "root - nproc 32768" >> /etc/security/limits.conf
echo "root - as unlimited" >> /etc/security/limits.conf
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
echo "vm.zone_reclaim_mode = 0" >> /etc/sysctl.conf
echo "vm.max_map_count = 131072" >> /etc/sysctl.conf

sysctl -p
