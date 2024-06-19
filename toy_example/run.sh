#!/bin/bash


#bam file paths and naames

tumor=bam/wxs_tumor.bam
normal=bam/wxs_normal.bam
rna=bam/rna.bam

#Designate which tools to run. Set Y to run. 

#MSIsensor
sensor=N

#MSIsensor2
sensor2=N

#MSIsensor-pro
pro=N

#MANTIS
mantis=Y

#MSIngs
msings=Y

#MSIsensor-RNA
sensor_rna=Y

#preMSIm
premsim=Y

#run MSIsensor

if [[ $sensor == "Y" ]]
then
bash scripts/sensor.sh $tumor $normal
fi

if [[ $sensor2 == "Y" ]]
then
bash scripts/sensor2.sh $tumor
fi

if [[ $pro == "Y" ]]
then
bash scripts/pro.sh $tumor
fi

if [[ $msings == "Y" ]]
then
bash scripts/msings.sh $tumor
fi







