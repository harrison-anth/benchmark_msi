#!/bin/sh
#SBATCH --job-name="cramer"
#SBATCH --output=../out_files/cramer.out
#SBATCH --error=../error_files/cramer.error
#SBATCH --partition="highmem","normal","MSC"
#SBATCH --mem-per-cpu=20G

status=$1
seq=$2
size=$3

line="$status"_"$seq"_"$size"_$SLURM_ARRAY_TASK_ID

gnar=$(cut -f 9 ../manifests/$line | tail -1)
gnar2=$(cut -f 6 ../manifests/$line | tail -1)
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

token=/data/Seoighe_data/Tokens/token_feb23

gnorts=$(tail -n +2 ../manifests/$line | cut -f 1)
name=$(tail -n +2 ../manifests/$line | cut -f 2)
newname=$name.ms


FILE=../"$status"_"$seq"/$sample/$gnar2.cram
if [ ! -f "$FILE" ]
then
gdc-client download --manifest ../manifests/$line --token $token --dir ../"$status"_"$seq"/$sample/

fi

sbatch cramer2.sh $status $seq $size $gnorts $name $gnar2 $sample $SLURM_ARRAY_TASK_ID
