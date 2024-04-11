#!/bin/sh
#SBATCH --job-name="TSO_GEN"
#SBATCH --output=../out_files/tso.out
#SBATCH --error=../error_files/tso.error
#SBATCH --partition="normal","MSC"
#SBATCH -a 1-104%5
#SBATCH --mem-per-cpu=20G

source /home/hanthony/anaconda3/etc/profile.d/conda.sh
conda activate msi-trials

ref=/data3/hanthony/reference_files/hg38.fa
tumor=../tso/bam/$(sed "${SLURM_ARRAY_TASK_ID}q;d" ../tso/SRR_Acc_List.txt).sorted.bam
baseline=../baselines/baseline_msi_sensor_pro.txt
baseline_msings=../baselines/msings_wxs.baseline
t_name=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ../tso/SRR_Acc_List.txt)
#msisensor-pro pro -d $baseline -t $tumor -o ../pro_results/tso/$tumor

#msisensor2 msi -d /data3/hanthony/reference_files/scan_tcga_ms.bed -t $tumor -M ../baselines/hg38_models/ -o ../sensor2_results/tso/$tumor

source /home/hanthony/anaconda3/etc/profile.d/conda.sh
conda activate /home/hanthony/anaconda3/envs/msi-trials/


BEDFILE=/data4/hanthony/tcga_msi_tools/bed_files/ms_sites_premium+.bed
REF_GENOME=/data3/hanthony/reference_files/hg38.fa
msings=/home/hanthony/bin/programs/msings/msi


#"multiplier" is the number of standard deviations from the baseline that is required to call instability
multiplier=2.0
#"msi_min_threshold" is the maximum fraction of unstable sites allowed to call a specimen MSI negative
msi_min_threshold=0.2
#"msi_max_threshold" is the minimum fraction of unstable sites allowed to call a specimen MSI positive
msi_max_threshold=0.2



mkdir -p ../msings_results/tso/$t_name
outdir=../msings_results/tso/$t_name

#samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE $tumor | awk '{if($4 >= 6) print $0}' > $outdir/$t_name.mpileup
#$msings analyzer $outdir/$t_name.mpileup $BEDFILE -o $outdir/$t_name.msi.txt
#$msings count_msi_samples $baseline_msings $outdir -m $multiplier -t $msi_min_threshold $msi_max_threshold \
#-o ../msings_results/tso/$t_name.MSI_Analysis.txt

#cleanup
rm -r $outdir




