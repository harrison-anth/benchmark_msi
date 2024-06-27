#!/bin/sh

#activate conda environment
eval "$(conda shell.bash hook)"

conda activate sensor

tumor=$1
normal=$2

echo "Running MSIsensor"

msisensor msi -d ../reference_files/chr7_scan.bed -n $normal -t $tumor -o output/msi_sensor_test

if [[ -f output/msi_sensor_test ]]
then
echo "MSIsensor test ran successfully."
echo "See output/msi_sensor_test for details."
fi

if [[ ! -f output/msi_sensor_test ]]
then
echo "MSIsensor test failed. Check program output for error messages."
fi

#wait 4 seconds for user to see success/failure of test

sleep 4

