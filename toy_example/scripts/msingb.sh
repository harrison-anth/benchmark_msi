#activate conda environment
eval "$(conda shell.bash hook)"
conda activate msingb

maf=$1

echo "Running MSINGB"

python ../reference_files/MSINGB/codes/msingb.py --maf $maf --outdir output/

if [[ -f output/preres.csv ]]
then
echo "MSINGB ran successfully."
echo "see output/preres.csv for details."
fi

if [[ ! -f output/preres.csv ]]
then
echo "MSINGB failed. Check program output for error messages."
fi

#wait 4 seconds for user to see success/fail outcome.

sleep 4
