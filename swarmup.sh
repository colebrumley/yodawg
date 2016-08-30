#!/bin/sh -x
until [ "$MASTER_IP" != "" ]; do
    MASTER_IP=$(nslookup master 2>/dev/null | awk 'NF {print $3}')
done
docker -H $MASTER_IP:2375 swarm init --advertise-addr $MASTER_IP
WORKER_TOKEN=$(docker -H $MASTER_IP:2375 swarm join-token worker -q)

CUR_LINES=0
while true; do
    COUNT=$(nslookup apprentice 2>/dev/null | awk 'NF {print $3}' | wc -l)
    if [ $COUNT -gt $CUR_LINES ]; then
        CUR_LINES=$COUNT
        for node in $(nslookup apprentice 2>/dev/null | awk 'NF {print $3}'); do
            docker -H $node:2375 swarm join --token $WORKER_TOKEN $MASTER_IP:2377
        done
    fi
    sleep 10 # The great equalizer
done
