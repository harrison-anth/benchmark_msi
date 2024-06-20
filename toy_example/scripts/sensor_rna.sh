#!/bin/sh

tumor=$1

#initialize conda shell
eval "$(conda shell.bash hook)"
conda activate sc_msi

featureCounts \
-t exon \
-p --countReadPairs \
-g gene_name -a ../reference_files/gencode_v36_GDC.h38_chr7.gtf \
-o temp/temp.counts \
$tumor

#shape gene count matrix for use with MSIsensor-RNA and preMSIm
conda activate premsim

Rscript scripts/sensor_rna_shaper.R


if [[ ! -f ../sensor_rna_results/all_samples.txt ]]
then

conda deactivate

msisensor-rna detection -i ../sensor_rna_results/all_samples.csv -o ../sensor_rna_results/all_samples.txt -m ../baselines/sensor_rna.model -d True

fi
