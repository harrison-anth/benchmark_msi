#!/bin/sh

echo "running MSIsensor"

#activate conda environment

conda activate sensor

tumor=$1
normal=$2

msisensor msi -d ../reference_files/chr7_scan.bed -n $normal -t $tumor -o output/msi_sensor_test
