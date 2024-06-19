#!/bin/sh

#activate conda environment
conda activate msings

##msings settings
tumor=$1

BEDFILE=../reference_files/ms_sites.bed
REF_GENOME=../reference_files/hg38_chr7.fa.gz
msings=../reference_files/msings/msi

#"multiplier" is the number of standard deviations from the baseline that is required to call instability
multiplier=2.0
#"msi_min_threshold" is the maximum fraction of unstable sites allowed to call a specimen MSI negative
msi_min_threshold=0.2
#"msi_max_threshold" is the minimum fraction of unstable sites allowed to call a specimen MSI positive
msi_max_threshold=0.2

#make temp directory to store pileup and msi analysis
mkdir -p temp/msings_test/
outdir=temp/msings_test/
echo "Running MSIngs"
#create pileup file
samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE $tumor | awk '{if($4 >= 6) print $0}' > $outdir/temp.mpileup
#analyze peaks
$msings analyzer $outdir/temp.mpileup $BEDFILE -o $outdir/temp.msi.txt
#generate summary information
$msings count_msi_samples ../baselines/msings_wxs.baseline $outdir -m $multiplier -t $msi_min_threshold $msi_max_threshold \
-o output/msings_test.txt

#cleanup 
rm $outdir
