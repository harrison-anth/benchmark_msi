#!/bin/sh
#SBATCH --job-name="Frank"
#SBATCH --output=../out_files/frank.out
#SBATCH --error=../error_files/frank.error
#SBATCH --partition="highmem","normal","MSC"

status=$1
seq=$2
size=$3
gnorts=$4
name=$5
gnar2=$6
sample=$7
NUMA=$8


FILE=../"$status"_"$seq"/$sample/$gnar2.cram
if [ ! -f "$FILE" ]
then
samtools view -T /data3/hanthony/reference_files/GRCh38.d1.vd1.fa -C -o ../"$status"_"$seq"/$sample/$gnar2.cram \
../"$status"_"$seq"/$sample/$gnorts/$name
samtools index ../"$status"_"$seq"/$sample/$gnar2.cram

rm -r ../"$status"_"$seq"/$sample/$gnorts/
fi
