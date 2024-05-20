#!/bin/sh
#SBATCH --job-name="mgiseq_aln"
#SBATCH --output=out_files/aln.out
#SBATCH --error=error_files/aln.error
#SBATCH -a 1-356
#SBATCH --partition="normal","highmem","MSC"

ref=/data3/hanthony/reference_files/GRCh38.d1.vd1.fa
gnorts=$(sed "${SLURM_ARRAY_TASK_ID}q;d" sorted_access_list.txt)
one=fastq/"$gnorts"_1.fastq.gz
two=fastq/"$gnorts"_2.fastq.gz
header=$(zcat $one | head -n 1)
id=$(echo $header | head -n 1 | cut -f 1-4 -d":" | sed 's/@//' | sed 's/:/_/g')
sm=$(echo $header | head -n 1 | grep -Eo "[ATGCN]+$")


FILE=bam/$gnorts.sorted.bam
if [ ! -f "$FILE" ]
then
bwa mem -R "@RG\tID:$id\tSM:$id"_"$sm\tLB:$id"_"$sm\tPL:ILLUMINA" \
$ref $one $two > bam/$gnorts.sam 

samtools view -b bam/$gnorts.sam > bam/$gnorts.bam
samtools sort -o bam/$gnorts.sorted.bam bam/$gnorts.bam
#samtools index bam/$gnorts.sorted.bam

cleanup
rm bam/$gnorts.sam
rm bam/$gnorts.bam

fi

FILE=bam/$gnorts.sorted.bam.bai
if [ ! -f "$FILE" ]
then
samtools index bam/$gnorts.sorted.bam
fi

