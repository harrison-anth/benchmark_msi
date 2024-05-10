#!/bin/sh
#SBATCH --job-name="count_tcga"
#SBATCH --output=../out_files/count_tcga.out
#SBATCH --error=../error_files/count_tcga.error
#SBATCH --partition="normal","highmem"
#SBATCH --array=1-826%5

module load Anaconda3

status=A
seq=rna
size=826


line="$status"_"$seq"_"$size"_$SLURM_ARRAY_TASK_ID

gnorts=$(tail -n +2 ../manifests/$line | cut -f 1)
name=$(tail -n +2 ../manifests/$line | cut -f 2)

conda activate sc_msi

if [[ ! -f ../count_matrices/$gnorts.counts ]]
then
#-p --countReadPairs if paired r1 r2 data in bam

featureCounts \
-t exon \
-p --countReadPairs \
-g gene_name -a /data3/hanthony/reference_files/gencode_v36_GDC.h38.gtf \
-o ../count_matrices/$gnorts.counts \
../A_rna/tumor/$gnorts/$name
fi

if [[ ! -f ../sensor2_results/A_rna/$name ]]
then
sbatch sensor2.sh $gnorts $status $seq $name
fi

if [[ ! -f ../msings_results/A_rna/$name.MSI_Analysis.txt ]]
then
MSI_BASELINE=../baselines/msings_rna_filtered.baseline
tumor=../A_rna/tumor/$gnorts/$name
sbatch msings.sh $MSI_BASELINE $tumor $status $seq $name
fi

if [[ ! -f ../pro_results/A_rna/$name ]]
then
MSI_BASELINE=../baselines/pro_rna/scan_tcga_ms.bed_baseline
tumor=../A_rna/tumor/$gnorts/$name
sbatch pro.sh $MSI_BASELINE $tumor $status $seq $name
fi

