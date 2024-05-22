#!/bin/sh
#SBATCH --job-name="msings"
#SBATCH --output=out_files/msings.out
#SBATCH --error=error_files/msings.error
#SBATCH --partition="normal","highmem"
#SBATCH --nice=10000

module load Anaconda3
conda activate msings
##msings settings
gnorts=$1

tumor=bam/"$gnorts"Aligned.sortedByCoord.out.bam
MSI_BASELINE=/data4/hanthony/tcga_msi_tools/baselines/msings_rna.baseline

dir=temp/"$gnorts"_msings
if [ ! -d "$dir" ]
then
mkdir $dir
fi


BEDFILE=/data4/hanthony/tcga_msi_tools/bed_files/ms_sites_premium+.bed
REF_GENOME=/data3/hanthony/reference_files/hg38.fa
msings=/home/hanthony/bin/programs/msings/msi

#"multiplier" is the number of standard deviations from the baseline that is required to call instability
multiplier=2.0
#"msi_min_threshold" is the maximum fraction of unstable sites allowed to call a specimen MSI negative
msi_min_threshold=0.2
#"msi_max_threshold" is the minimum fraction of unstable sites allowed to call a specimen MSI positive
msi_max_threshold=0.2


mkdir -p temp/"$gnorts"
outdir=temp/"$gnorts"

samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE $tumor | awk '{if($4 >= 6) print $0}' > $outdir/$gnorts.mpileup
$msings analyzer $outdir/$gnorts.mpileup $BEDFILE -o $outdir/$gnorts.msi.txt
$msings count_msi_samples $MSI_BASELINE $outdir -m $multiplier -t $msi_min_threshold $msi_max_threshold \
-o msings_results/$gnorts.MSI_Analysis.txt


#clean-up
if [[ -f msings_results/"$gnorts".MSI_Analysis.txt ]] 
then
rm -r $outdir
fi
