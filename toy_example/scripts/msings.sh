#!/bin/sh

#activate conda environment
conda activate msings

##msings settings
tumor=$1

BEDFILE=../bed_files/ms_sites_premium+.bed
REF_GENOME=../reference_files/hg38_chr7.fa
msings=/home/hanthony/bin/programs/msings/msi

#"multiplier" is the number of standard deviations from the baseline that is required to call instability
multiplier=2.0
#"msi_min_threshold" is the maximum fraction of unstable sites allowed to call a specimen MSI negative
msi_min_threshold=0.2
#"msi_max_threshold" is the minimum fraction of unstable sites allowed to call a specimen MSI positive
msi_max_threshold=0.2


mkdir -p /data4/hanthony/tcga_msi_tools/msings_results/"$status"_"$seq"/$t_name
outdir=/data4/hanthony/tcga_msi_tools/msings_results/"$status"_"$seq"/$t_name

samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE $tumor | awk '{if($4 >= 6) print $0}' > $outdir/$t_name.mpileup
$msings analyzer $outdir/$t_name.mpileup $BEDFILE -o $outdir/$t_name.msi.txt
$msings count_msi_samples $MSI_BASELINE $outdir -m $multiplier -t $msi_min_threshold $msi_max_threshold \
-o ../msings_results/"$status"_"$seq"/$t_name.MSI_Analysis.txt


#clean-up
if [[ -f ../msings_results/"$status"_"$seq"/$t_name.MSI_Analysis.txt ]] 
then
rm -r $outdir
fi
