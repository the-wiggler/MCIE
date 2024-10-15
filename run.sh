#!/bin/bash

run_plot() {
    while true; do
        read -p "Would you like to plot the data? (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done 
}

gfortran MCIE.f90 -o MCIE -fopenmp

if [ $? -eq 0 ]; then
    echo "COMPILATION SUCCESSFUL...RUNNING PROGRAM"
    ./MCIE
    echo "INTEGRAL ESTIMATION COMPLETE"
fi
if run_plot; then
        echo "PLOTTING DATA"
        python3 dataplot.py
    else
        echo "CSV FILE OUTPUT IN DIRECTORY"
fi
rm MCIE
