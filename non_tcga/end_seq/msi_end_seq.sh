#!/bin/sh
#SBATCH --job-name="tso_endseq"
#SBATCH --output=out_files/tso.out
#SBATCH --error=error_files/tso.error
#SBATCH --mem-per-cpu=30G
#SBATCH --partition="normal"

source /home/hanthony/anaconda3/etc/profile.d/conda.sh
gnorts=$1

conda activate pro

ref=/data3/hanthony/reference_files/hg38.fa
tumor=bam/"$gnorts".sorted.bam
baseline=/data4/hanthony/tcga_msi_tools/baselines/20_ran_wgs.baseline
baseline_msings=/data4/hanthony/tcga_msi_tools/baselines/msings_wgs.baseline
t_name=$gnorts
if [ ! -f pro/$gnorts ]
then

msisensor-pro pro -d $baseline -t $tumor -c 20 -o pro/$t_name
fi
if [ ! -f sensor2/$gnorts ]
then

msisensor2 msi -d /data4/hanthony/tcga_msi_tools/bed_files/scan_tcga_ms.bed -t $tumor -M /data4/hanthony/tcga_msi_tools/baselines/hg38_models/ -o \
sensor2/$t_name
fi
if [ ! -f msings/$gnorts.MSI_analysis.txt ]
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



mkdir -p msings/$t_name
outdir=msings/$t_name

samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE $tumor | awk '{if($4 >= 6) print $0}' > $outdir/$t_name.mpileup
$msings analyzer $outdir/$t_name.mpileup $BEDFILE -o $outdir/$t_name.msi.txt
$msings count_msi_samples $baseline_msings $outdir -m $multiplier -t $msi_min_threshold $msi_max_threshold \
-o msings/$t_name.MSI_analysis.txt

#cleanup
#rm -r $outdir
fi



