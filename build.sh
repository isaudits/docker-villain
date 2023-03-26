#!/bin/bash

docker build -t isaudits/villain .
docker image prune -f