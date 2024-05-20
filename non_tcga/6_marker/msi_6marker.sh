#!/bin/sh
#SBATCH --job-name="tso_mgi"
#SBATCH --output=out_files/tso.out%a
#SBATCH --error=error_files/tso.error%a
#SBATCH --mem-per-cpu=30G
#SBATCH --array=1-178
#SBATCH --partition="normal","highmem","MSC"
source /home/hanthony/anaconda3/etc/profile.d/conda.sh

end=$(( $SLURM_ARRAY_TASK_ID*2 ))
start=$(( $end - 1 ))
norm_id=$(sed "${start}q;d" sorted_access_list.txt)
tum_id=$(sed "${end}q;d" sorted_access_list.txt)
tumor=bam/"$tum_id".sorted.bam 
normal=bam/"$norm_id".sorted.bam
t_name=$tum_id
sensor_bed=/data3/hanthony/reference_files/scan_tcga_ms.bed
baseline_sensor2=/data4/hanthony/tcga_msi_tools//baselines/hg38_models/
baseline_pro=/data4/hanthony/tcga_msi_tools/baselines/20_ran_wxs.baseline
baseline_msings=/data4/hanthony/tcga_msi_tools/baselines/msings_wxs.baseline
gnorts=$tum_id

conda activate pro

if [ ! -f pro/$gnorts ] 
then
msisensor-pro pro -d $baseline_pro -t $tumor -o pro/$t_name
rm pro/"$t_name"*_*
fi

if [ ! -f sensor2/$gnorts ]
then
msisensor2 msi -d $sensor_bed -t $tumor -M $baseline_sensor2 -o sensor2/$t_name
rm sensor2/"$t_name"*_*
fi

if [ ! -f sensor/$gnorts ]
then
msisensor msi -d $sensor_bed -n $normal -t $tumor -o sensor/$t_name
rm sensor/"$t_name"*_*
fi

if [ ! -f msings/$gnorts.MSI_Analysis.txt ]
then
conda activate msings

BEDFILE=/data4/hanthony/tcga_msi_tools/bed_files/ms_sites_premium+.bed
REF_GENOME=/data3/hanthony/reference_files/hg38.fa
msings=/home/hanthony/bin/programs/msings/msi
MSI_BASELINE=$baseline_msings
#"multiplier" is the number of standard deviations from the baseline that is required to call instability
multiplier=2.0
#"msi_min_threshold" is the maximum fraction of unstable sites allowed to call a specimen MSI negative
msi_min_threshold=0.2
#"msi_max_threshold" is the minimum fraction of unstable sites allowed to call a specimen MSI positive
msi_max_threshold=0.2

mkdir -p msings_results/"$status"_"$seq"/$t_name
outdir=msings_results/"$status"_"$seq"/$t_name

samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE $tumor | awk '{if($4 >= 6) print $0}' > $outdir/$t_name.mpileup
$msings analyzer $outdir/$t_name.mpileup $BEDFILE -o $outdir/$t_name.msi.txt
$msings count_msi_samples $MSI_BASELINE $outdir -m $multiplier -t $msi_min_threshold $msi_max_threshold \
-o msings/$t_name.MSI_Analysis.txt

rm -r $outdir

fi

if [ ! -f mantis/$gnorts.status ]
then
conda activate mantis

python /home/hanthony/bin/programs/MANTIS/mantis.py \
-n $normal -t $tumor -b /data4/hanthony/tcga_msi_tools/bed_files/mantis.bed -o mantis/$t_name \
--genome /data3/hanthony/reference_files/hg38.fa --threads 1 -mrq 10.0 -mlq 15.0 -mlc 10 -mrr 1
fi
