#!/bin/bash

docker compose down
#./sync.sh
docker compose up --build --detach
