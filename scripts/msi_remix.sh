#!/bin/sh
#SBATCH --job-name="msi_remix"
#SBATCH --output=../out_files/remix.out
#SBATCH --error=../error_files/remix.error
#SBATCH --partition="normal","highmem","MSC"
#SBATCH --array=1-352


#settings refresher for wgs#
##settings for run 1##
status=A
seq=wgs
sample=T
size=352
random=F
paired=T




##setting refresher for wxs##
#status=A
#seq=wxs
#sample=T
#size=852
#random=F
#paired=T
#run which programs?
pro=F
mantis=F
sensor=F
sensor2=T
msings=F
mim=T




if [[ "$seq" == "wxs" ]]
then
baseline_pro=../baselines/20_ran_wxs.baseline
else
baseline_pro=../baselines/20_ran_wgs.baseline
fi


if [[ "$seq" == "wxs" ]]
then
baseline_msings=../baselines/msings_wxs.baseline
else
baseline_msings=../baselines/msings_wgs.baseline
fi

tumor=$(cut -f 1 ../manifests/"$status"_"$seq"_"$size".pair"$SLURM_ARRAY_TASK_ID" | tail -n +2)
normal=$(cut -f 2 ../manifests/"$status"_"$seq"_"$size".pair"$SLURM_ARRAY_TASK_ID" | tail -n +2)
t_name=$tumor

tumor=../"$status"_"$seq"/tumor/$tumor.ms.sorted.bam
normal=../"$status"_"$seq"/normal/$normal.ms.sorted.bam

if [[ "$mantis" == "T" ]]
then
FILE=../mantis_results/"$status"_"$seq"/$t_name.status
if [ ! -f "$FILE" ]
then
sbatch mantis.sh $normal $tumor $status $seq $t_name
fi
fi


if [[ "$sensor" == "T" ]]
then
FILE=../sensor_results/"$status"_"$seq"/$t_name
if [ ! -f "$FILE" ]
then
sbatch sensor.sh $tumor $status $seq $t_name $normal
fi
fi


if [[ "$pro" == "T" ]]
then
FILE=../pro_results/"$status"_"$seq"/$t_name
if [ ! -f "$FILE" ]
then
sbatch pro.sh $baseline_pro $tumor $status $seq $t_name
fi
fi

if [[ "$sensor2" == "T" ]]
then
FILE=../sensor2_results/"$status"_"$seq"/$t_name
if [ ! -f "$FILE" ]
then 
sbatch sensor2.sh $tumor $status $seq $t_name
fi
fi
if [[ "$msings" == "T" ]]
then
FILE=../msings_results/"$status"_"$seq"/$t_name.MSI_Analysis.txt
if [ ! -f "$FILE" ]
then
sbatch msings.sh $baseline_msings $tumor $status $seq $t_name
fi
fi

