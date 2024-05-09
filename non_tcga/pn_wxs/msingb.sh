#!/bin/sh
#SBATCH --job-name="msingb"
#SBATCH --output=out_files/msingb.out
#SBATCH --error=error_files/msingb.error
#SBATCH --mem=10G

module load Anaconda3
conda activate msingb

tum_id=$1


if [[ ! -d msingb_results/$tum_id ]]
then
mkdir msingb_results/$tum_id
fi

if [[ ! -f msingb_results/$tum_id/preres.csv ]]
then

python /home/hanthony/bin/programs/MSINGB/codes/msingb.py --maf maf/$tum_id.maf --outdir msingb_results/$tum_id

rm msingb_results/$tum_id/feature.csv
rm msingb_results/$tum_id/tagged.csv

fi


