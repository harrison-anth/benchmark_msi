#!/bin/sh
#SBATCH --job-name="Gnorts"
#SBATCH --output=../out_files/gnorts.out
#SBATCH --error=../error_files/gnorts.error
#SBATCH --partition="normal","highmem","MSC"
#SBATCH --mem-per-cpu=30G

status=$1
seq=$2
size=$3
maf=$4
stats=$5

####Use this code to get around slurm array task id limit
#sum=$(($SLURM_ARRAY_TASK_ID + 999))
#
#SLURM_ARRAY_TASK_ID=$sum
############



line="$status"_"$seq"_"$size"_$SLURM_ARRAY_TASK_ID




gnar=$(cut -f 9 ../manifests/$line | tail -1)
if [[ "$gnar" == "N" ]]
then
sample=normal
elif [[ "$gnar" == "N*" ]]
then
sample=normal
elif [[ "$gnar" == "T" ]]
then
sample=tumor
fi

token=/home/hanthony/tokens/gdc

gnorts=$(tail -n +2 ../manifests/$line | cut -f 1)
name=$(tail -n +2 ../manifests/$line | cut -f 2)
gnar2=$name.ms

if [ $maf == "T" ]
then
sbatch maf_gen.sh $status $seq $size $gnorts $name $gnar2 $sample $SLURM_ARRAY_TASK_ID
fi

if [ $stats == "T" ]
then
sbatch stats.sh $status $seq $size $gnorts $name $gnar2 $sample $SLURM_ARRAY_TASK_ID
fi


FILE=../"$status"_"$seq"/$sample/$gnar2.sorted.bam
if [ ! -f "$FILE" ]
then
cp ../A_"$seq"/$sample/$gnar2.sorted.bam ../"$status"_"$seq"/$sample/$gnar2.sorted.bam
cp ../A_"$seq"/$sample/$gnar2.sorted.bam.bai ../"$status"_"$seq"/$sample/$gnar2.sorted.bam.bai

fi

sbatch filer.sh $status $seq $size $gnorts $name $gnar2 $sample $SLURM_ARRAY_TASK_ID 

