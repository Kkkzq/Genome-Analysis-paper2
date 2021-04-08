#!/bin/bash -l

#SBATCH -A g2021012
#SBATCH -M snowy  
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:10:00
#SBATCH -J reads_quality_control_rna_seq_raw
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools
module load FastQC

# Your commands
for i in /home/ziqi/Ziqi_Genome_Analysis/2_Eckalbar_2016/sel3/rna_seq_data/raw/*.fastq.gz
        do
                echo "Running $i ..."
                fastqc -t 1 -o /home/ziqi/Ziqi_Genome_Analysis/result/1_quality_control/rna_seq_data/raw "$i"
        done