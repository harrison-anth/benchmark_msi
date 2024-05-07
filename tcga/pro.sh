#!/bin/sh
#SBATCH --job-name="PRO"
#SBATCH --output=../out_files/pro.out
#SBATCH --error=../error_files/pro.error
#SBATCH --partition="normal","highmem"
#SBATCH --nice=10000
baseline=$1
tumor=$2
status=$3
seq=$4
t_name=$5
module load Anaconda3

conda activate pro
dir=/data4/hanthony/tcga_msi_tools/pro_results/"$status"_"$seq"/
if [ ! -d "$dir" ]
then
mkdir $dir
fi

if [[ "$seq" == "wxs" ]]
then
msisensor-pro pro -d $baseline -t $tumor -c 20 -o "$dir""$t_name"
else
msisensor-pro pro -d $baseline -t $tumor -o "$dir""$t_name"
fi

