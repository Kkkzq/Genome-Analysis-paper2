#!/bin/bash -l

#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 13:00:00
#SBATCH -J softmask_wgs
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools
module load RepeatMasker/4.1.0

# Your command
RepeatMasker -q /home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/softmask/closed_gaps.fasta -e ncbi -lib /home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/repeatscout/genome.repseq.fa -xsmall # takes ~1m

# not using the library
RepeatMasker -q -species mammal /home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/softmask/closed_gaps.fasta -xsmall