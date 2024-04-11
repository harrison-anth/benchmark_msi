#!/bin/sh
#SBATCH --job-name="exon"
#SBATCH --output=../out_files/exon.out
#SBATCH --error=../error_files/exon.error
#SBATCH --time=10-00:05:00



status=$1
seq=$2
size=$3
gnorts=$4
name=$5
gnar2=$6
sample=$7
NUMA=$8


FILE=../temp/$name.sorted.exon
if [ ! -f "$FILE" ]
then
samtools view -b -h -L ../bed_files/exon_final.bed ../"$status"_"$seq"/$sample/$gnar2.sorted.bam > ../temp/$name.exon
samtools sort ../temp/$name.exon -o ../temp/$name.sorted.exon
samtools index ../temp/$name.sorted.exon
fi

#push to msi-tools

sbatch exon_passer.sh $status $seq $size $NUMA $sample $name

 
#done
