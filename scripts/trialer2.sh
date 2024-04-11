#!/bin/bash

##Run these jobs##

#Generate new manifests?
new_manifests=T

#Generate mafs?
maf=F

#new status
status=msih
sample=T
seq=wgs
size=1
random=T
paired=T



sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf
#new status
