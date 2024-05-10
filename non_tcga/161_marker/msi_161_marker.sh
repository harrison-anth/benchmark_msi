#!/bin/sh
#SBATCH --job-name="msi_161_marker"
#SBATCH --output=out_files/msi.out
#SBATCH --error=error_files/msi.error
#SBATCH --mem-per-cpu=30G
#SBATCH --partition="normal","highmem"
#SBATCH --nice=1000

module load Anaconda3
gnorts=$1

conda activate pro

ref=/data3/hanthony/reference_files/GRCh38.d1.vd1.fa
tumor=bam/"$gnorts".sorted.bam
baseline=/data4/hanthony/tcga_msi_tools/baselines/20_ran_wgs.baseline
baseline_msings=/data4/hanthony/tcga_msi_tools/baselines/msings_wgs.baseline
t_name=$gnorts

if [ ! -f pro_results/$gnorts ]
then

msisensor-pro pro -d $baseline -t $tumor -c 20 -o pro_results/$t_name
fi

if [ ! -f sensor2_results/$gnorts ]
then

msisensor2 msi -d /data4/hanthony/tcga_msi_tools/bed_files/scan_tcga_ms.bed -t $tumor -M /data4/hanthony/tcga_msi_tools/baselines/hg38_models/ -o \
sensor2_results/$t_name
fi
if [ ! -f msings_results/$gnorts.MSI_analysis.txt ]
then
conda activate msings



BEDFILE=/data4/hanthony/tcga_msi_tools/bed_files/ms_sites_premium+.bed
REF_GENOME=$ref
msings=/home/hanthony/bin/programs/msings/msi


#"multiplier" is the number of standard deviations from the baseline that is required to call instability
multiplier=2.0
#"msi_min_threshold" is the maximum fraction of unstable sites allowed to call a specimen MSI negative
msi_min_threshold=0.2
#"msi_max_threshold" is the minimum fraction of unstable sites allowed to call a specimen MSI positive
msi_max_threshold=0.2



mkdir -p msings_results/$t_name
outdir=msings_results/$t_name

samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE $tumor | awk '{if($4 >= 6) print $0}' > $outdir/$t_name.mpileup
$msings analyzer $outdir/$t_name.mpileup $BEDFILE -o $outdir/$t_name.msi.txt
$msings count_msi_samples $baseline_msings $outdir -m $multiplier -t $msi_min_threshold $msi_max_threshold \
-o msings_results/$t_name.MSI_analysis.txt

#cleanup
rm -r $outdir
fi



