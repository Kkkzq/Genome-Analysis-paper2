#!/bin/bash -l
#SBATCH -A g2021012
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 03:00:00
#SBATCH -J genome_assembly_soapdenovo
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools

# Your commands
/sw/bioinfo/SOAPdenovo/2.04-r240/rackham/bin/SOAPdenovo-63mer all \
-s /home/ziqi/Ziqi_Genome_Analysis/script/soapdenovo_config.txt \
-K 49 \
-o /home/ziqi/Ziqi_Genome_Analysis/result/3_dna_assembly/soapdenovo/output