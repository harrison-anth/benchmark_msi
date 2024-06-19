#!/bin/sh

#activate conda environment

conda activate sensor

tumor=$1
normal=$2

echo "Running MSIsensor"

msisensor msi -d ../reference_files/chr7_scan.bed -n $normal -t $tumor -o output/msi_sensor_test

if [[ -f output/msi_sensor_test/ ]]
then
echo "MSIsensor test ran successfully"
fi

if [[ ! -f output/msi_sensor_test/ ]]
then
echo "MSIsensor test failed. Check program output for error messages."
fi

wait 4
