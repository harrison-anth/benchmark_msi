#!/bin/sh

#load conda environment
conda activate sensor

echo "Running MSIsensor-pro"

tumor=$1

msisensor-pro pro -d ../baselines/sensor_pro_wxs_chr7.baseline -t $tumor -c 20 -o output/pro_test

if [[ -f output/pro_test ]]
then
echo "MSIsensor-pro test ran successfully"
fi

if [[ ! -f output/pro_test ]]
then
echo "MSIsensor-pro test failed. Check program output for error messages."
fi

wait 4
