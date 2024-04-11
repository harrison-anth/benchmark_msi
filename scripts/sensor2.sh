#!/bin/sh
#SBATCH --job-name="sensor2"
#SBATCH --output=../out_files/sensor2.out
#SBATCH --error=../error_files/sensor2.error
#SBATCH --partition="MSC","normal","highmem"

module load Anaconda3

conda activate pro

tumor=$1
status=$2
seq=$3
t_name=$4

dir=/data4/hanthony/tcga_msi_tools/sensor2_results/"$status"_"$seq"/
if [ ! -d "$dir" ]
then
mkdir $dir
fi


if [[ "$seq" == "wgs" ]]
then
msisensor2 msi -d /data3/hanthony/reference_files/scan_tcga_ms.bed -t $tumor -M ../baselines/hg38_models/ -c 5 -o "$dir""$t_name"
else
msisensor2 msi -d /data3/hanthony/reference_files/scan_tcga_ms.bed -t $tumor -M ../baselines/hg38_models/ -o "$dir""$t_name"
fi


rm "$dir""$t_name"_*
