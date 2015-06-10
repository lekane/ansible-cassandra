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

HOSTNAME=$(hostname)
export TOKENS=$(nodetool info -T | grep ^Token | awk '{ print $3 }' | tr \\n , | sed -e 's/,$/\n/')

if [ -d "/etc/dse" ]; then
   CASSANDRA_CONF_DIR=/etc/dse/cassandra
else
   CASSANDRA_CONF_DIR=/etc/cassandra
fi

cp $CASSANDRA_CONF_DIR/cassandra.yaml $CASSANDRA_CONF_DIR/cassandra.yaml.pre_token_bak

sed -i -e '/initial_token:/s/.*/initial_token: '$TOKENS/ $CASSANDRA_CONF_DIR/cassandra.yaml

echo $TOKENS | tee $CASSANDRA_CONF_DIR/TOKENS