#!/bin/bash

if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' 
    RED='\033[0;31m' 
    GREEN='\033[0;32m' 
    ORANGE='\033[0;33m' 
    BLUE='\033[0;34m' 
    PURPLE='\033[0;35m' 
    CYAN='\033[0;36m' 
    LIGHT_GREY='\033[0;37m'
    GREY='\033[0;38m'
    YELLOW='\033[1;33m'

    COLORS_DEFINED=1
else
    NOFORMAT='' 
    RED='' 
    GREEN='' 
    ORANGE='' 
    BLUE='' 
    PURPLE='' 
    CYAN='' 
    YELLOW=''
    GREY=''
    LIGHT_GREY=''

    COLORS_DEFINED=0
fi

