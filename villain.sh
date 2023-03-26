#!/bin/bash

while [ $# -gt 0 ]; do
    if [[ $1 == "--"* ]]; then
        v="${1/--/}"
        declare "$v"="$2"
        shift
    fi
    shift
done

SRV_PORT=${SRV_PORT:-65001}
HOAX_PORT=${HOAX_PORT:-443}
NC_PORT=${NC_PORT:-4443}

docker run -it --rm \
    -p $SRV_PORT:$SRV_PORT -p $HOAX_PORT:$HOAX_PORT -p $NC_PORT:$NC_PORT \
    -e SRV_PORT=$SRV_PORT -e HOAX_PORT=$HOAX_PORT -e NC_PORT=$NC_PORT \
    isaudits/villain