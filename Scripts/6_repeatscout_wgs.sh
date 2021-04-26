#!/bin/bash -l

#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J repeatscout_preparemask_wgs
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools
module load RepeatScout/1.0.6

# Your command

build_lmer_table -sequence /home/ziqi/Ziqi_Genome_Analysis/result/3_dna_assembly/soapdenovo_gapcloser/closed_gaps.fasta -freq /home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/repeatscout/genome.freq
# list of repeat sequences

RepeatScout -sequence /home/ziqi/Ziqi_Genome_Analysis/result/3_dna_assembly/soapdenovo_gapcloser/closed_gaps.fasta -output /home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/repeatscout/genome.repseq.fa -freq /home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/repeatscout/genome.freq

# This step can't run
cd /home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/repeatscout
cat genome.repseq.fa | filter-stage-1.prl > /home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/repeatscout/genome.repseq.f1.fa
# Remove repeats detected by RepeatScout that are too short or of low complexity
cat genome.repseq.f1.fa | filter-stage-2.prl --cat=genome.fa.out > genome.repseq.f2.fa