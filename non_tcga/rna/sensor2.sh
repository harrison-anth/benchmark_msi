#!/bin/sh
#SBATCH --job-name="sensor2"
#SBATCH --output=out_files/sensor2.out
#SBATCH --error=error_files/sensor2.error
#SBATCH --partition="normal","highmem"

module load Anaconda3

conda activate pro

gnorts=$1
tumor=bam/"$gnorts"Aligned.sortedByCoord.out.bam
if [ ! -f sensor2_results/$gnorts ]
then

msisensor2 msi -d /data3/hanthony/reference_files/scan_tcga_ms.bed -t $tumor -M /data4/hanthony/tcga_msi_tools/baselines/hg38_models/ -c 5 -o sensor2_results/$gnorts

fi
