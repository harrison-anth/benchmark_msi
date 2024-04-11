#!/bin/sh
#SBATCH --job-name="Filer"
#SBATCH --output=../out_files/filer.out
#SBATCH --error=../error_files/filer.error
#SBATCH --partition="normal","highmem"

status=$1
seq=$2
size=$3
gnorts=$4
name=$5
gnar2=$6
sample=$7
NUMA=$8

FILE=../"$status"_"$seq"/$sample/$gnar2.sorted.bam
if [ ! -f "$FILE" ]
then
samtools view -b -h -L ../bed_files/ms_sites_premium+.bed ../"$status"_"$seq"/$sample/$gnorts/$name > ../"$status"_"$seq"/$sample/$gnar2.bam
samtools sort ../"$status"_"$seq"/$sample/$gnar2.bam -o ../"$status"_"$seq"/$sample/$gnar2.sorted.bam
samtools index ../"$status"_"$seq"/$sample/$gnar2.sorted.bam

rm -r ../"$status"_"$seq"/$sample/$gnorts/
rm ../"$status"_"$seq"/$sample/$gnar2.bam
fi

#push to msi-tools

sbatch msi_passer.sh $status $seq $size $NUMA $sample $name

 
