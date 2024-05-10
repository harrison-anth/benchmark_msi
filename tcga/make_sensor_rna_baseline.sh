#!/bin/bash

module load Anaconda3

conda activate sensor_rna

#get list of significant genes

msisensor-rna genes -i training_expressions.csv -o sensor_rna_training_genes.csv

#create model from filtered expression.csv based on results of genes command

msisensor-rna train -i filtered_sensor_training_data.csv -o filtered_model.model


