#!/bin/sh
#SBATCH --partition="normal","highmem"
#SBATCH --mem=10G
#SBATCH --job-name="sensor_rna"
#SBATCH --output=out_files/rna.out
#SBATCH --error=error_files/rna.error

module load Anaconda3

if [[ ! -f sensor_rna_results/all_samples.csv ]]
then

conda activate premsim

Rscript sensor_rna_shaper.R
fi

if [[ ! -f sensor_rna_results/all_samples.txt ]]
then

conda deactivate

msisensor-rna detection -i sensor_rna_results/all_samples.csv -o sensor_rna_results/all_samples.txt \
-m /data4/hanthony/tcga_msi_tools/baselines/sensor_rna.model -d True

fi
