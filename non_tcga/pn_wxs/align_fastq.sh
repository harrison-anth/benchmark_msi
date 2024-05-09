#!/bin/sh
#SBATCH --job-name="aln_pn_wxs"
#SBATCH --output=out_files/aln.out
#SBATCH --error=error_files/aln.error
#SBATCH --partition="normal","highmem"
#SBATCH --array=1-42

module load Anaconda3


gnorts=$(sed "${SLURM_ARRAY_TASK_ID}q;d" access_list.txt)

ref=/data3/hanthony/reference_files/GRCh38.d1.vd1.fa

one=fastq/"$gnorts"_1.fastq.gz
two=fastq/"$gnorts"_2.fastq.gz
header=$(zcat $one | head -n 1)
id=$(echo $header | head -n 1 | cut -f 1-4 -d":" | sed 's/@//' | sed 's/:/_/g')
sm=$(echo $header | head -n 1 | grep -Eo "[ATGCN]+$")





if [[ ! -f bam/$gnorts.sorted.bam ]]
then

bwa mem -R "@RG\tID:$id\tSM:$id"_"$sm\tLB:$id"_"$sm\tPL:ILLUMINA" \
$ref $one $two > bam/$gnorts.sam 

samtools view -b bam/$gnorts.sam > bam/$gnorts.bam
samtools sort -o bam/$gnorts.sorted.bam bam/$gnorts.bam
rm bam/$gnorts.bam
samtools index bam/$gnorts.sorted.bam

#cleanup
rm bam/$gnorts.sam
rm bam/$gnorts.bam

fi
