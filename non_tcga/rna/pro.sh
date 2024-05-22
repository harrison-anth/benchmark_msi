#!/bin/sh
#SBATCH --job-name="PRO"
#SBATCH --output=out_files/pro.out
#SBATCH --error=error_files/pro.error
#SBATCH --partition="normal","highmem"

baseline=/data4/hanthony/tcga_msi_tools/baselines/pro_rna/scan_tcga_ms.bed_baseline
gnorts=$1
tumor=bam/"$gnorts"Aligned.sortedByCoord.out.bam

module load Anaconda3

conda activate pro

msisensor-pro pro -d $baseline -t $tumor -o pro_results/$gnorts

