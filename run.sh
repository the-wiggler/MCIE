#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

run_plot() {
    while true; do
        read -p "Would you like to plot the data? (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo -e "${YELLOW}Please answer yes (y) or no (n).${NC}";;
        esac
    done 
}

gfortran MCIE.f90 -o MCIE -fopenmp

if [ $? -eq 0 ]; then
    echo -e "${GREEN}COMPILATION SUCCESSFUL...RUNNING PROGRAM${NC}"
    ./MCIE
    echo -e "${GREEN}INTEGRAL ESTIMATION COMPLETE${NC}"
else
    echo -e "${RED}COMPILATION FAILED${NC}"
    exit 1
fi

if run_plot; then
    echo -e "${GREEN}PLOTTING DATA${NC}"
    python3 dataplot.py
else
    echo -e "${YELLOW}CSV FILE OUTPUT IN DIRECTORY${NC}"
fi

rm MCIE
