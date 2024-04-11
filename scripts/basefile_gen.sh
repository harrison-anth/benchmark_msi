#!/bin/sh
#SBATCH --job-name="msings_baseline"
#SBATCH --output=../out_files/msings_baseline.out
#SBATCH --error=../error_files/msings_baseline.error
#SBATCH --partition="normal"
#SBATCH --mem-per-cpu=20G


source /home/hanthony/anaconda3/etc/profile.d/conda.sh
conda activate /home/hanthony/anaconda3/envs/msi-trials/



##msings baseline gen
BEDFILE=/data4/hanthony/tcga_msi_tools/bed_files/ms_sites_premium+.bed;
BAM_LIST=/data4/hanthony/tcga_msi_tools/A_wgs/normal/norm_files.txt;
REF_GENOME=/data3/hanthony/reference_files/hg38.fa;
msings=/home/hanthony/bin/programs/msings/msi

BAM=$(sed -n "$SLURM_ARRAY_TASK_ID"p "$BAM_LIST")
SAVEPATH=/data4/hanthony/tcga_msi_tools/baseline_wgs_files
BAMNAME=$(basename $BAM)
PFX=${BAMNAME%.*}
mkdir -p $SAVEPATH/$PFX
echo “Starting Analysis of $PFX” >> $SAVEPATH/$PFX/msi_run_log.txt;
date +"%D %H:%M" >> $SAVEPATH/$PFX/msi_run_log.txt;


    echo "Making mpileups" >> $SAVEPATH/$PFX/msi_run_log.txt;
    date +"%D %H:%M" >> $SAVEPATH/$PFX/msi_run_log.txt;
    samtools mpileup -f $REF_GENOME -d 100000 -A -E -l $BEDFILE /data4/hanthony/tcga_msi_tools/A_wgs/normal/$BAM| awk '{if($4 >= 6) print $0}' > $SAVEPATH/$PFX/$PFX.mpileup

    echo "MSI Analyzer start" >> $SAVEPATH/$PFX/msi_run_log.txt;
    date +"%D %H:%M" >> $SAVEPATH/$PFX/msi_run_log.txt;

    $msings analyzer $SAVEPATH/$PFX/$PFX.mpileup $BEDFILE -o $SAVEPATH/$PFX/$PFX.msi.txt

    echo "MSI calls start" >> $SAVEPATH/$PFX/msi_run_log.txt;
    date +"%D %H:%M" >> $SAVEPATH/$PFX/msi_run_log.txt;
 echo “Completed Analysis of $PFX” >> $SAVEPATH/$PFX/msi_run_log.txt;
    date +"%D %H:%M" >> $SAVEPATH/$PFX/msi_run_log.txt;







###msi sensor-pro baseline gen
#msisensor-pro baseline -d /data3/hanthony/reference_files/scan_tcga_ms.bed -i /data4/hanthony/tcga_msi_tools/A_wgs/normal/20_wgs_cram.txt \
#-c 15 -b 8 -g /data3/hanthony/reference_files/GRCh38.d1.vd1.fa -o ../baseline_20wgs/
