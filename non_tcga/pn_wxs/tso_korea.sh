#!/bin/sh
#SBATCH --job-name="tso_korea"
#SBATCH --output=out_files/tso.out
#SBATCH --error=error_files/tso.error
#SBATCH --time=10-00:05:00
#SBATCH --mem-per-cpu=30G
#SBATCH --array=11-21

module load Anaconda3


cd /define/home/hanthony/korea
end=$(( $SLURM_ARRAY_TASK_ID*2 ))
start=$(( $end - 1 ))
tum_id=$(sed "${start}q;d" korea_access_list.txt)
norm_id=$(sed "${end}q;d" korea_access_list.txt)
baseline_pro=/define/home/hanthony/tcga_msi_tools/baselines/20_ran_wxs.baseline
baseline_msings=/define/home/hanthony/tcga_msi_tools/baselines/msings_wxs.baseline

tumor=bam/"$tum_id".sorted.bam 
normal=bam/"$norm_id".sorted.bam
t_name=$tum_id


conda activate msi-trials
msisensor-pro pro -d $baseline_pro -t $tumor -c 20 -o pro/$t_name

ref=/define/home/hanthony/reference_files/scan_tcga_ms.bed
msisensor msi -d $ref -n $normal -t $tumor -o sensor/$t_name

bed=/define/home/hanthony/tcga_msi_tools/bed_files/scan_tcga_ms.bed

msisensor2 msi -d $bed -t $tumor -M /define/home/hanthony/tcga_msi_tools/baselines/hg38_models/ -o \
sensor2/$t_name

conda activate msings

BEDFILE=/define/home/hanthony/tcga_msi_tools/bed_files/ms_sites_premium+.bed
REF_GENOME=/define/home/hanthony/reference_files/hg38.fa
msings=/define/home/hanthony/programs/msings/msi

#"multiplier" is the number of standard deviations from the baseline that is required to call instability
multiplier=2.0
#"msi_min_threshold" is the maximum fraction of unstable sites allowed to call a specimen MSI negative
msi_min_threshold=0.2
#"msi_max_threshold" is the minimum fraction of unstable sites allowed to call a specimen MSI positive
msi_max_threshold=0.2

mkdir -p msings/"$status"_"$seq"/$t_name
outdir=msings/"$status"_"$seq"/$t_name


samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE $tumor | awk '{if($4 >= 6) print $0}' > $outdir/$t_name.mpileup
$msings analyzer $outdir/$t_name.mpileup $BEDFILE -o $outdir/$t_name.msi.txt
$msings count_msi_samples $MSI_BASELINE $outdir -m $multiplier -t $msi_min_threshold $msi_max_threshold \
-o ../msings_results/"$status"_"$seq"/$t_name.MSI_Analysis.txt

conda activate mantis
ref=/define/home/hanthony/reference_files/hg38.fa
python /define/home/hanthony/programs/MANTIS/mantis.py \
-n $normal -t $tumor -b /define/home/hanthony/tcga_msi_tools/bed_files/mantis.bed -o mantis/$t_name \
--genome $ref --threads 1 -mrq 20.0 -mlq 25.0 -mlc 10 -mrr 1

