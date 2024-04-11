#!/bin/sh
#SBATCH --job-name="mantis"
#SBATCH --output=../out_files/mantis.out
#SBATCH --error=../error_files/mantis.error
#SBATCH --partition="normal","highmem"
#SBATCH --mem-per-cpu=30G
#SBATCH --nice=10000

module load Anaconda3

###I think there is an issue with the mantis conda dist. Worked with VM git clone.
conda activate mantis

normal=$1
tumor=$2
status=$3
seq=$4
t_name=$5

dir=/data4/hanthony/tcga_msi_tools/mantis_results/"$status"_"$seq"/
if [ ! -d "$dir" ]
then
mkdir $dir
fi




if [[ "$seq" == "wxs" ]]
then
python /home/hanthony/bin/programs/MANTIS/mantis.py \
-n $normal -t $tumor -b ../bed_files/mantis.bed -o "$dir""$t_name" \
--genome /data3/hanthony/reference_files/hg38.fa --threads 1 -mrq 20.0 -mlq 25.0 -mlc 20 -mrr 1
else
python /home/hanthony/bin/programs/MANTIS/mantis.py \
-n $normal -t $tumor -b ../bed_files/mantis.bed -o "$dir""$t_name" \
--genome /data3/hanthony/reference_files/hg38.fa --threads 1 -mrq 10.0 -mlq 15.0 -mlc 10 -mrr 1
fi

rm "$dir""$t_name"*bam
