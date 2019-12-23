#!/usr/bash

# COLOR PALETTE FOR TERMINAL 
#
# Knowledge:
# https://en.wikipedia.org/wiki/ANSI_escape_code
#
#
# echo -e      - The -e parameter makes escaped (backslashed) strings will be interpreted (style in this case)
# \091         - Escaped sequence represents beginning/ending of the style
# lowercase m  - Indicates the end of the sequence
# 1            - Style attribute (see chart below)
# [0m          - Resets all attributes, colors, formatting, etc. (that makes all text after normal, this is 
#                bound to "NC" variable)
#
# Possible Styles:
#
# 0 - Normal Style 
# 1 - Bold
# 2 - Dim 
# 4 - Underlined 
# 5 - Blinking 
# 7 - Reverse 
# 8 - Invisible
#

RED='\e[0;31m'
lRED='\e[0;91m'
lbRED='\e[1;91m'

GREEN='\e[0;32m'
bGREEN='\e[1;32m'
lGREEN='\e[0;92m'
lbGREEN='\e[1;92m'

lbYELLOW='\e[1;93m'

GRAY='\e[0;30m'	
lGRAY='\e[0;37m'
lbGRAY='\e[1;37m'

NC='\e[0m'
