#!/bin/bash -l

#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 10:00:00
#SBATCH -J softmask_wgs
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools
module load RepeatMasker/4.1.0

# Your command
RepeatMasker -species -mam /home/ziqi/Ziqi_Genome_Analysis/result/6_softmask/closed_gaps.fasta
