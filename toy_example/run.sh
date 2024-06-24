#!/bin/bash

eval "$(conda shell.bash hook)"


#bam file paths and naames

tumor=bam/wxs_tumor.bam
normal=bam/wxs_normal.bam
rna=temp/SRR15197363.counts
maf=temp/SRR14555852.maf

#Designate which tools to run. Set Y to run. The relevant conda
#environments must be installed.

#MSIsensor
sensor=N

#MSIsensor2
sensor2=N

#MSIsensor-pro
pro=N

#MANTIS
mantis=N

#MSIngs
msings=N

#MSINGB
#NB: As there is no conda package for MSINGB, we have included a tarball that needs to be unpacked in the ../reference_files/ directory. 
#Even though this toy example uses a maf file as an example, there are examples of taking files from vcf to MSINGB results in the tcga and non_tcga
#results directories. 

msingb=Y

#MSIsensor-RNA
#NB: A local installation of MSIsensor-RNA is required as there is no conda package for it.

sensor_rna=N

#preMSIm
premsim=N



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

if [[ $mantis == "Y" ]]
then
bash scripts/mantis.sh $tumor $normal
fi

if [[ $msingb == "Y" ]]
then
bash scripts/msingb.sh $maf
fi

if [[ $sensor_rna == "Y" ]]
then
bash scripts/sensor_rna.sh $rna
fi

if [[ $premsim == "Y" ]]
then
bash scripts/premsim.sh $rna
fi







