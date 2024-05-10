#!/bin/sh
#SBATCH --job-name="baseline_gen"
#SBATCH --output=../out_files/pro_baseline.out
#SBATCH --error=../error_files/pro_baseline.error
#SBATCH --partition="normal","highmem"

module load Anaconda3

conda activate pro

#for WGS / RNA
msisensor-pro baseline -d /data3/hanthony/reference_files/scan_tcga_ms.bed \
-i /data4/hanthony/tcga_msi_tools/A_wgs/normal/20_wgs_cram.txt \
-c 15 -b 8 -g /data3/hanthony/reference_files/GRCh38.d1.vd1.fa -o ../baseline_20wgs/

#for WXS

msisensor-pro baseline -d /data3/hanthony/reference_files/scan_tcga_ms.bed \
-i /data4/hanthony/tcga_msi_tools/A_wgs/normal/20_wgs_cram.txt \
-c 20 -g /data3/hanthony/reference_files/GRCh38.d1.vd1.fa -o ../baseline_20wxs/

