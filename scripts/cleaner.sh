#!/bin/sh
#SBATCH --job-name="cleaner"
#SBATCH --output=../out_files/cleaner.out
#SBATCH --error=../error_files/cleaner.error
#SBATCH --partition="normal","highmem","MSC"

rm -r ../msih_wgs/normal/* &
rm -r ../msih_wxs/normal/* &
rm -r ../msil_wgs/normal/* &
rm -r ../msil_wxs/normal/* &
rm -r ../mss_wgs/normal/* &
rm -r ../mss_wxs/normal/* &

rm -r ../msih_wgs/tumor/* &
rm -r ../msih_wxs/tumor/* &
rm -r ../msil_wgs/tumor/* &
rm -r ../msil_wxs/tumor/* &
rm -r ../mss_wgs/tumor/* &
rm -r ../mss_wxs/tumor/* &
#rm ../manifests/* &


#rm -r ../A_wgs/tumor/*
#rm -r ../A_wgs/normal/*
#rm -r ../A_wxs/tumor/*
#rm -r ../A_wxs/normal/*

#rm -r ../maf/A_wgs/*
#rm -r ../maf/A_wxs/*
#rm -r ../maf/msih_wgs/*
#rm -r ../maf/msih_wxs/*
#rm -r ../maf/msil_wgs/*
#rm -r ../maf/msil_wxs/*
#rm -r ../maf/mss_wgs/*
#rm -r ../maf/mss_wxs/*
#rm -r ../maf/tso/*






rm ../pro_results/msih_wxs/*
rm ../pro_results/msil_wxs/*
rm ../pro_results/mss_wxs/*
#rm ../pro_results/A_wxs/*

rm ../pro_results/msih_wgs/*
rm ../pro_results/msil_wgs/*
rm ../pro_results/mss_wgs/*
#rm ../pro_results/A_wgs/*


rm ../sensor_results/msih_wxs/*
rm ../sensor_results/msil_wxs/*
rm ../sensor_results/mss_wxs/*
#rm ../sensor_results/A_wxs/*

rm ../sensor_results/msih_wgs/*
rm ../sensor_results/msil_wgs/*
rm ../sensor_results/mss_wgs/*
#rm ../sensor_results/A_wgs/*

rm ../sensor2_results/msih_wxs/*
rm ../sensor2_results/msil_wxs/*
rm ../sensor2_results/mss_wxs/*
#rm ../sensor2_results/A_wxs/*


rm ../sensor2_results/msih_wgs/*
rm ../sensor2_results/msil_wgs/*
rm ../sensor2_results/mss_wgs/*
#rm ../sensor2_results/A_wgs/*


rm ../mantis_results/msih_wxs/*
rm ../mantis_results/msil_wxs/*
rm ../mantis_results/mss_wxs/*
#rm ../mantis_results/A_wxs/*

rm ../mantis_results/msih_wgs/*
rm ../mantis_results/msil_wgs/*
rm ../mantis_results/mss_wgs/*
#rm ../mantis_results/A_wgs/*

rm -r ../msings_results/msih_wxs/*
rm -r ../msings_results/msil_wxs/*
rm -r ../msings_results/mss_wxs/*
#rm -r ../msings_results/A_wxs/*

rm -r ../msings_results/msih_wgs/*
rm -r ../msings_results/msil_wgs/*
rm -r ../msings_results/mss_wgs/*
#rm -r ../msings_results/A_wgs/*
#rm -r ../temp/*




wait


