#!/bin/sh
#SBATCH --job-name="exon2"
#SBATCH --output=../out_files/exon2.out
#SBATCH --error=../error_files/exon2.error
#SBATCH --partition="normal"
#SBATCH --nice=10000



status=$1
seq=$2
size=$3
gnorts=$4
name=$5
gnar2=$6
sample=$7
NUMA=$8
subsample=$9

name_new="$name"_"$subsample"

FILE=../temp/$name_new.sorted.exon
if [ ! -f "$FILE" ]
then
samtools view -bs 1.$subsample ../"$status"_"$seq"/$sample/$gnar2.sorted.bam > ../temp/$name_new.exon
samtools sort ../temp/$name_new.exon -o ../temp/$name_new.sorted.exon
samtools index ../temp/$name_new.sorted.exon
fi

#push to msi-tools
sbatch exon_passer.sh $status $seq $size $NUMA $sample $name $name_new $subsample

 
#done
