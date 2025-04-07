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
INSECURE=${INSECURE:-false}

printf "Starting Villain with the following parameters:\n"
printf "SRV_PORT: $SRV_PORT\n"
printf "HOAX_PORT: $HOAX_PORT\n"
printf "NC_PORT: $NC_PORT\n"
printf "INSECURE: $INSECURE\n"

docker run -it --rm \
        -p $SRV_PORT:$SRV_PORT -p $HOAX_PORT:$HOAX_PORT -p $NC_PORT:$NC_PORT \
        -e SRV_PORT=$SRV_PORT -e HOAX_PORT=$HOAX_PORT -e NC_PORT=$NC_PORT -e INSECURE=$INSECURE \
        isaudits/villain


