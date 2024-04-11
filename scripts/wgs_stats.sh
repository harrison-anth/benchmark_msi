#!/bin/sh
#SBATCH --job-name="stats"
#SBATCH --partition="normal"
#SBATCH --output=../out_files/stats.out
#SBATCH --error=../error_files/stats.error
#SBATCH --mem-per-cpu=30G
#SBATCH -a 1-100%5

token=/data/Seoighe_data/Tokens/token_apr23

status=A
seq=wgs
size=100
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

gnorts=$(tail -n +2 ../manifests/$line | cut -f 1)
name=$(tail -n +2 ../manifests/$line | cut -f 2)
gnar2=$name.ms




NUMA=$SLURM_ARRAY_TASK_ID

FILE1=../seq_stats/depth/$name.avg_depth
FILE2=../seq_stats/mapping/$name.map
FILE3=../seq_stats/mapping/$name.mapQ
FILE4=../seq_stats/depth/$gnar2.avg_depth
FILE5=../seq_stats/mapping/$gnar2.map
FILE6=../seq_stats/mapping/$gnar2.mapQ



if [ ! -f "$FILE1" ] || [ ! -f "$FILE2" ] || [ ! -f "$FILE3" ] || [ ! -f "$FILE4" ] || [ ! -f "$FILE5" ] || [ ! -f "$FILE6" ] 
then
gdc-client download --manifest ../manifests/$line --token $token --dir ../temp/
samtools view -b -h -L ../bed_files/ms_sites_premium+.bed ../temp/$gnorts/$name > \
../temp/$gnar2.bam
samtools sort ../temp/$gnar2.bam -o ../temp/$gnar2.sorted.bam
samtools index ../temp/$gnar2.sorted.bam &

if [ ! -f "$FILE1" ]
then
samtools depth ../temp/$gnorts/$name |  awk '{sum+=$3} END { print "Average = ",sum/NR}' > $FILE1 &
fi

if [ ! -f "$FILE2" ]
then
samtools flagstat ../temp/$gnorts/$name > $FILE2 &
fi

if [ ! -f "$FILE3" ]
then
samtools view ../temp/$gnorts/$name | awk '{sum+=$5} END { print "Mean MAPQ =",sum/NR}' > $FILE3 &
fi



wait


if [ ! -f "$FILE4" ]
then
samtools depth ../temp/$gnar2.sorted.bam | awk '{sum+=$3} END { print "Average = ",sum/NR}' > $FILE4 &
fi

if [ ! -f "$FILE5" ]
then
samtools flagstat ../temp/$gnar2.sorted.bam > $FILE5 &
fi

if [ ! -f "$FILE6" ]
then
samtools view ../temp/$gnorts/$gnar2.sorted.bam | awk '{sum+=$5} END { print "Mean MAPQ =",sum/NR}' > $FILE6 &
fi

fi

wait

rm -r ../temp/$gnorts/
rm ../temp/$gnar2*
rm ../temp/$name*

#done

