#!/bin/sh

echo "Running MSIsensor2"

conda activate sensor

tumor=$1

msisensor2 msi -d ../reference_files/chr7_scan.bed -t $tumor -M ../baselines/hg38_models/ -o output/sensor2_test


