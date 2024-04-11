#!/bin/sh
#SBATCH --job-name="MIM"
#SBATCH --output=../out_files/mim.out
#SBATCH --error=../error_files/mim.error
#SBATCH --partition="MSC"
#SBATCH --mem-per-cpu=30G
#SBATCH --nice=10000
conda activate mim

mim=/home/hanthony/bin/programs/MIMcall/RUN_MIM_CALL.pl

start_time="$(date -u +%s)"

perl $mim -N_BAM ../A_wgs/normal/fea37e9c-c745-4688-96f3-77e8a42137e2_wgs_gdc_realn.bam.ms.sorted.bam \
-C_BAM ../A_wgs/tumor/ffb4f42b-58e9-40c3-8963-11804f041375_wgs_gdc_realn.bam.ms.sorted.bam \
-OUT ../mim_results/A_wgs/test.mim \
-MS /data4/hanthony/tcga_msi_tools/bed_files/all_ms_sites.bed
end_time="$(date -u +%s)"

elapsed="$(($end_time-$start_time))"
echo "Total of $elapsed seconds elapsed for process"

