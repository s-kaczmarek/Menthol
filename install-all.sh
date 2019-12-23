#!/bin/bash

PATH_TO_SCRIPTS_REPO=./src

for script in "$PATH_TO_SCRIPTS_REPO"/*.sh
do
    bash "$script" -H
done