#!/bin/sh
#SBATCH --job-name="endseq_aln"
#SBATCH --output=out_files/aln%a.out
#SBATCH --error=error_files/aln%a.error
#SBATCH -a 1-36
#SBATCH --partition="normal","highmem"

ref=/data3/hanthony/reference_files/GRCh38.d1.vd1.fa
gnorts=$(sed "${SLURM_ARRAY_TASK_ID}q;d" new_runs.txt)
one=fastq/"$gnorts".fastq.gz
header=$(zcat $one | head -n 1)
id=$(echo $header | head -n 1 | cut -f 1-4 -d":" | sed 's/@//' | sed 's/:/_/g')
sm=$(echo $header | head -n 1 | grep -Eo "[ATGCN]+$")

FILE=bam/$gnorts.sorted.bam
if [ ! -f "$FILE" ]
then
bwa mem -R "@RG\tID:$id\tSM:$id"_"$sm\tLB:$id"_"$sm\tPL:ILLUMINA" \
$ref $one > bam/$gnorts.sam 

samtools view -b bam/$gnorts.sam > bam/$gnorts.bam
samtools sort -o bam/$gnorts.sorted.bam bam/$gnorts.bam
samtools index bam/$gnorts.sorted.bam

#cleanup
rm bam/$gnorts.sam
rm bam/$gnorts.bam

fi


#sbatch msi_end_seq.sh $gnorts
