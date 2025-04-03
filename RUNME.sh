#!/usr/bin/env bash

FILEID=1WIN043c4o_tXv2AdPYAQQ4RsoRk5dk3T
FILENAME=square_walk.bag
DATAFOLDER=dataset

if ! test -f $DATAFOLDER/$FILENAME; then
  mkdir -p $DATAFOLDER
  curl "https://drive.usercontent.google.com/download?id={$FILEID}&confirm" -o $DATAFOLDER/$FILENAME
fi

export UID
export GID=`id -g`

docker compose up

