#!/bin/bash -l
#SBATCH -A g2021012
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J rna_trimming
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools
module load trimmomatic

# Your commands
java -jar /sw/apps/bioinfo/trimmomatic/0.36/rackham/trimmomatic-0.36.jar PE -phred33 \
/home/ziqi/Ziqi_Genome_Analysis/raw_data/sel3/rna_seq_data/raw/sel3_SRR1719266.2.fastq.gz \
/home/ziqi/Ziqi_Genome_Analysis/raw_data/sel3/rna_seq_data/raw/sel3_SRR1719266.1.fastq.gz \
/home/ziqi/Ziqi_Genome_Analysis/result/2_trimming/sel3_SRR1719266.trim_2P.fastq.gz \
/home/ziqi/Ziqi_Genome_Analysis/result/2_trimming/sel3_SRR1719266.trim_2U.fastq.gz \
/home/ziqi/Ziqi_Genome_Analysis/result/2_trimming/sel3_SRR1719266.trim_1P.fastq.gz \
/home/ziqi/Ziqi_Genome_Analysis/result/2_trimming/sel3_SRR1719266.trim_1U.fastq.gz \
ILLUMINACLIP:/sw/bioinfo/trimmomatic/0.36/rackham/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36