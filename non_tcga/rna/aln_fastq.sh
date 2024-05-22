#!/bin/sh
#SBATCH --job-name="aln_fastq"
#SBATCH --output=out_files/aln.out
#SBATCH --error=error_files/aln.error
#SBATCH --partition="normal","highmem"
#SBATCH --array=1-190

module load Anaconda3

gnorts=$(sed "${SLURM_ARRAY_TASK_ID}q;d" access_list.txt)

ref=/data3/hanthony/reference_files/GRCh38_star_genome_files

one=fastq/"$gnorts"_1.fastq.gz
two=fastq/"$gnorts"_2.fastq.gz

header=$(zcat $one | head -n 1)
id=$(echo $header | head -n 1 | cut -f 1-4 -d":" | sed 's/@//' | sed 's/:/_/g')
sm=$(echo $header | head -n 1 | grep -Eo "[ATGCN]+$")

conda activate sc_msi

if [[ ! -f bam/"$gnorts"Aligned.sortedByCoord.out.bam ]]
then


STAR --runThreadN 10 \
--readFilesIn $one $two \
--genomeDir $ref \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix bam/$gnorts \
--readFilesCommand zcat


fi
if [[ ! -f bam/"$gnorts"Aligned.sortedByCoord.out.bam.bai ]]
then
samtools index bam/"$gnorts"Aligned.sortedByCoord.out.bam
fi


sbatch gen_count_matrix.sh $gnorts
