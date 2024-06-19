#!/bin/sh

#load conda environment
conda activate sensor

echo "running MSIsensor-pro"

tumor=$1

msisensor-pro pro -d ../baselines/sensor_pro_wxs_chr7.baseline -t $tumor -c 20 -o output/pro_test

