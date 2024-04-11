#!/bin/bash
#SBATCH --partition="normal","MSC"
#SBATCH --job-name="dl"
#SBATCH --output=../out_files/dl.out
#SBATCH --error=../error_files/dl.error



rsync -avzP hanthony@217.74.56.73:/define/home/hanthony/tcga_msi_tools/A_wgs/tumor/* ../A_wgs/tumor/
rsync -avzP hanthony@217.74.56.73:/define/home/hanthony/tcga_msi_tools/A_wgs/normal/* ../A_wgs/normal/

