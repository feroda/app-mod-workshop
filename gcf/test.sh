#!/bin/bash

set -euo pipefail

# This is riccardo way to get env variables and then invoke python code after populating them
# You should NOT need this script.

source ~/git/app-mod-workshop-set-by-step/.env

export DB_USER=$DB_USER
export DB_PASS=$DB_PASS
export DB_HOST=$DB_HOST
export DB_NAME=$DB_NAME

python test.py
