#!/bin/sh
#SBATCH --job-name="msings baseline"
#SBATCH --output=../out_files/msings_baseline.out
#SBATCH --error=../error_files/msings_baseline.error
#SBATCH --partition="normal","highmem"
#SBATCH --mem-per-cpu=30G
#SBATCH --array 1-20

module load Anaconda3
conda activate msings
seq=rna
BEDFILE=/data4/hanthony/tcga_msi_tools/bed_files/ms_sites_premium+.bed
REF_GENOME=/data3/hanthony/reference_files/hg38.fa
msings=/home/hanthony/bin/programs/msings/msi

#"multiplier" is the number of standard deviations from the baseline that is required to call instability
multiplier=2.0
#"msi_min_threshold" is the maximum fraction of unstable sites allowed to call a specimen MSI negative
msi_min_threshold=0.2
#"msi_max_threshold" is the minimum fraction of unstable sites allowed to call a specimen MSI positive
msi_max_threshold=0.2

norm_name=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ../manifests/"$seq"_ran20_name.txt)
norm_file=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ../manifests/"$seq"_ran20_id.txt)

mkdir -p ../temp/$seq/$norm_name/
outdir=../temp/$seq/$norm_name/

samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE ../A_rna/normal/$norm_file/$norm_name | awk '{if($4 >= 6) print $0}' > $outdir/$norm_name.mpileup
$msings analyzer $outdir/$norm_name.mpileup $BEDFILE -o ../baselines/msings_files/$seq/$norm_name.msi.txt


#run once
#$msings create_baseline ../baselines/msings_files/$seq/ -o ../baselines/msings_$seq.baseline

#wait
#cleanup
#if [[ -d $outdir ]] 
#then
#rm -r $outdir
