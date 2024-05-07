#!/bin/sh
#SBATCH --job-name="msings"
#SBATCH --output=../out_files/msings.out
#SBATCH --error=../error_files/msings.error
#SBATCH --partition="normal","highmem"
#SBATCH --mem-per-cpu=10G
#SBATCH --nice=10000
module load Anaconda3
conda activate msings
##msings settings
MSI_BASELINE=$1
tumor=$2
status=$3
seq=$4
t_name=$5



dir=/data4/hanthony/tcga_msi_tools/msings_results/"$status"_"$seq"/
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
