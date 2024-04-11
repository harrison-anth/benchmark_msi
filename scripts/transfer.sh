#!/bin/bash
#SBATCH --partition="normal","highmem","MSC"
#SBATCH --job-name="manitee"
#SBATCH --output=../out_files/manifest.out
#SBATCH --error=../error_files/manifest.error

rsync -arvh \
--inplace \
--compress-level=9 \
--progress \
hanthony@217.74.56.73:/define/home/hanthony/tcga_msi_tools/A_wgs/normal/*.sorted.bam* \
/data4/hanthony/tcga_msi_tools/A_wgs/normal/
