#!/bin/bash

# Use this script to store all paths to other scripts. If you want to add dependency to other scripts just 
# set source to this file.
#
# TODO conssider script that will check and write all the paths into this file, so it will
# be easier to update paths in case of reorganising project structure.
#
# TODO conssider function to check integrity of whole project files before run!

source ./scripts/install/*
source ./scripts/runs/*
source ./scripts/utils/*