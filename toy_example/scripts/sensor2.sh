#!/bin/sh

#activate conda environment
eval "$(conda shell.bash hook)"
conda activate sensor

tumor=$1

echo "Running MSIsensor2"

msisensor2 msi -d ../reference_files/chr7_scan.bed -t $tumor -M ../baselines/hg38_models/ -o output/sensor2_test

if [[ -f output/sensor2_test ]]
then
echo "MSIsensor2 test ran successfully."
echo "See output/sensor2_test for details."
fi

if [[ ! -f output/sensor2_test ]]
then
echo "MSIsensor2 test failed. Check program output for error messages."
fi

#wait 4 seconds for user to see success/failure of test

sleep 4

