#!/bin/sh

module load Anaconda3

if [[ ! -f ../sensor_rna_results/all_samples.csv ]]
then

conda activate premsim

Rscript sensor_rna_shaper.R
fi

if [[ ! -f ../sensor_rna_results/all_samples.txt ]]
then

conda deactivate

msisensor-rna detection -i ../sensor_rna_results/all_samples.csv -o ../sensor_rna_results/all_samples.txt -m ../baselines/sensor_rna.model -d True

fi
