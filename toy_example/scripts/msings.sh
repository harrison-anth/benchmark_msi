#!/bin/sh

#activate conda environment
eval "$(conda shell.bash hook)"
conda activate msings

##msings settings
tumor=$1

BEDFILE=../reference_files/ms_sites_chr7.bed
REF_GENOME=../reference_files/GRCh38.d1.vd1_chr7.fa.gz
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
echo "Running MSIngs. Note: pileup generation can take upwards of 10 minutes."
#create pileup file
samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE $tumor | awk '{if($4 >= 6) print $0}' > $outdir/temp.mpileup
#analyze peaks
$msings analyzer $outdir/temp.mpileup $BEDFILE -o $outdir/temp.msi.txt
#generate summary information
$msings count_msi_samples ../baselines/msings_wxs.baseline $outdir -m $multiplier -t $msi_min_threshold $msi_max_threshold \
-o output/msings_test.txt

#cleanup
if [[ -d $outdir ]]
then
rm -r $outdir
fi

if [[ -f output/msings_test.txt ]]
then
echo "MSIngs test ran successfully."
echo "See output/msings_test.txt for details."
fi

if [[ ! -f output/msings_test.txt ]]
then
echo "MSIngs test failed. Check program output for error messages."
fi

#wait 4 seconds for user to see success/failure of test

sleep 4

