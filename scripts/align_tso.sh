#!/bin/sh
#SBATCH --job-name="TSO_GEN"
#SBATCH --output=../out_files/tso.out
#SBATCH --error=../error_files/tso.error
#SBATCH --partition="normal"
#SBATCH -a 1-104

ref=/data3/hanthony/reference_files/hg38.fa
gnorts=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ../tso/SRR_Acc_List.txt)

one=../tso/fastq/"$gnorts".fastq
header=$(cat $one | head -n 1)
id=$(echo $header | head -n 1 | cut -f 1-4 -d":" | sed 's/@//' | sed 's/:/_/g')
sm=$(echo $header | head -n 1 | grep -Eo "[ATGCN]+$")


FILE=../tso/bam/$gnorts.sorted.bam
if [ ! -f "$FILE" ]
then
bwa mem -R "@RG\tID:$id\tSM:$id"_"$sm\tLB:$id"_"$sm\tPL:ILLUMINA" \
$ref ../tso/fastq/"$gnorts".fastq > ../tso/bam/$gnorts.sam 

samtools view -b ../tso/bam/$gnorts.sam > ../tso/bam/$gnorts.bam
rm ../tso/bam/$gnorts.sam
samtools sort -o ../tso/bam/$gnorts.sorted.bam ../tso/bam/$gnorts.bam
rm ../tso/bam/$gnorts.bam
samtools index ../tso/bam/$gnorts.sorted.bam
fi

