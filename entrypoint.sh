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

cd /usr/share/villain

# Generate a passphrase
openssl rand -base64 48 > passphrase.txt

# Generate a Private Key
openssl genrsa -aes128 -passout file:passphrase.txt -out server.key 2048

# Generate a CSR (Certificate Signing Request)
openssl req -new -passin file:passphrase.txt -key server.key -out server.csr \
    -subj "/C=US/O=Microsoft/OU=Domain Control Validated/CN=buyme.a.beer"

# Remove Passphrase from Key
cp server.key server.key.org
openssl rsa -in server.key.org -passin file:passphrase.txt -out server.key

# Generating a Self-Signed Certificate for 100 years
openssl x509 -req -days 36500 -in server.csr -signkey server.key -out server.crt

if [ $INSECURE = true ]; then
    printf "Insecure mode enabled. Using insecure connection.\n"
    python3 Villain.py -p $SRV_PORT -x $HOAX_PORT -n $NC_PORT -c server.crt -k server.key -i
else
    python3 Villain.py -p $SRV_PORT -x $HOAX_PORT -n $NC_PORT -c server.crt -k server.key
fi