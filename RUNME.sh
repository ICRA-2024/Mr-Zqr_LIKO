#!/usr/bin/env bash

if ! curl -V &>/dev/null; then
  echo "Prerequisite error: curl not found"
  exit 1
fi

if ! docker -v &>/dev/null; then
  echo "Prerequisite error: Docker not found"
  exit 1
fi

if ! nvidia-container-toolkit --version &>/dev/null; then
  echo "Prerequisite error: NVIDIA container toolkit not found"
  exit 1
fi

if ! docker compose version &>/dev/null; then
  echo "Prerequisite error: Docker compose plugin not found"
  exit 1
fi

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

