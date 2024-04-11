#!/bin/sh
#SBATCH --job-name="sensor"
#SBATCH --output=../out_files/sensor.out
#SBATCH --error=../error_files/sensor.error
#SBATCH --partition="normal","highmem"
#SBATCH --nice=10000

module load Anaconda3
conda activate pro


tumor=$1
status=$2
seq=$3
t_name=$4
normal=$5
dir=/data4/hanthony/tcga_msi_tools/sensor_results/"$status"_"$seq"/
if [ ! -d "$dir" ]
then
mkdir $dir
fi



if [[ "$seq" == "wgs" ]]
then
msisensor msi -d /data3/hanthony/reference_files/scan_tcga_ms.bed -n $normal -t $tumor -c 15 -o "$dir""$t_name"
else
msisensor msi -d /data3/hanthony/reference_files/scan_tcga_ms.bed -n $normal -t $tumor -o "$dir""$t_name"
fi

rm "$dir""$t_name"_*
