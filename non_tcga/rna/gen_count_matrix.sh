#!/bin/sh
#SBATCH --job-name="count_korea"
#SBATCH --output=out_files/count_korea.out
#SBATCH --error=error_files/count_korea.error
#SBATCH --partition="normal","highmem"

module load Anaconda3

gnorts=$1
conda activate sc_msi

if [[ ! -f count_matrices/$gnorts.counts ]]
then
featureCounts -p --countReadPairs -t exon \
-g gene_name -a /data3/hanthony/reference_files/gencode_v36_GDC.h38.gtf \
-o count_matrices/$gnorts.counts \
bam/"$gnorts"Aligned.sortedByCoord.out.bam
fi

if [[ ! -f sensor2_results/$gnorts ]] 
then
sbatch sensor2.sh $gnorts
fi

if [[ ! -f msings_results/$gnorts.MSI_Analysis.txt ]]
then
sbatch msings.sh $gnorts
fi

if [[ ! -f pro_results/$gnorts ]]
then
sbatch pro.sh $gnorts
fi
