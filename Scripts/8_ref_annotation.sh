#!/bin/bash -l

#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 03:00:00
#SBATCH -J annotation_braker_wgs
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# load modules
module load bioinfo-tools
module load braker/2.1.5
module load augustus/3.2.3_Perl5.24.1
module load bamtools/2.5.1
module load blast/2.9.0+
module load GenomeThreader/1.7.0
module load samtools/1.8
module load GeneMark/4.62-es

# Your Command
export AUGUSTUS_CONFIG_PATH=/home/ziqi/Ziqi_Genome_Analysis/result/8_ref_annotation/config
export AUGUSTUS_BIN_PATH=/sw/bioinfo/augustus/3.4.0/snowy/bin
export AUGUSTUS_SCRIPTS_PATH=/sw/bioinfo/augustus/3.4.0/snowy/scripts
export GENEMARK_PATH=/sw/bioinfo/GeneMark/4.62-es/snowy

cd /home/ziqi/Ziqi_Genome_Analysis/result/8_ref_annotation

/sw/bioinfo/braker/2.1.5/snowy/scripts/braker.pl --species=Mnat --AUGUSTUS_CONFIG_PATH=/home/ziqi/Ziqi_Genome_Analysis/result/8_ref_annotation/config --genome=/home/ziqi/Ziqi_Genome_Analysis/unziped_data/sel3_NW_015504249.fna --bam=/home/ziqi/Ziqi_Genome_Analysis/result/8_ref_annotation/new_bamfile/merge_paired.bam --softmasking --cores 1
