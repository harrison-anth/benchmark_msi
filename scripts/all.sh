#!/bin/bash

##Run these jobs##

#Generate new manifests?
new_manifests=F


#Generate mafs?
maf=F

#Generate stats?
stats=F

#downsample exome?
exome=F
#proportion of reads to downsample to
subsample=NA

##settings for run 1##
status=A
seq=wgs
sample=T
size=352
random=F
paired=T

sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats $exome $subsample


##settings for run 2##
status=A
seq=wxs
sample=T
size=852
random=F
paired=T

#sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats $exome $subsample
