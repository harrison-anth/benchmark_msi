#!/bin/bash

##Run these jobs##

#Generate new manifests?
new_manifests=F

#Generate mafs?
maf=F

#Generate stats?
stats=T

##settings for run 1##
status=A
seq=wgs
sample=T
size=100
random=T
paired=T

sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats


##settings for run 2##
status=A
seq=wxs
sample=T
size=200
random=T
paired=T

sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats

##settings for run 3##

status=mss
seq=wxs
sample=T
size=20
random=T
paired=T

sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats

#new status
status=msih
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats
#new status
status=msil
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats

##settings for run 4##
status=mss
seq=wgs
sample=T
size=10
random=T
paired=T

sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats
##new status
status=msih
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats
#new status
status=msil
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats





#done
