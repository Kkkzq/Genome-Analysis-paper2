#!/bin/bash -l

#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 03:00:00
#SBATCH -J annotation_braker_wgs
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools
module load braker/2.1.5
module load augustus/3.2.3_Perl5.24.1
module load bamtools/2.5.1
module load blast/2.9.0+
module load GenomeThreader/1.7.0
module load samtools/1.8
module load GeneMark/4.62-es

# Your Command
export AUGUSTUS_BIN_PATH=/sw/bioinfo/augustus/3.4.0/snowy/bin
export AUGUSTUS_SCRIPTS_PATH=/sw/bioinfo/augustus/3.4.0/snowy/scripts
export GENEMARK_PATH=/sw/bioinfo/GeneMark/4.62-es/snowy

cd /home/ziqi/Ziqi_Genome_Analysis/result/8_braker_annotation/bamfile
/sw/bioinfo/braker/2.1.5/snowy/scripts/braker.pl --species=Mnat --min_contig=5000 --AUGUSTUS_CONFIG_PATH=/home/ziqi/Ziqi_Genome_Analysis/result/8_braker_annotation/config --genome=/home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/softmask/new_genome.fa --bam=sel3_SRR1719013.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719018.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719211.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719013.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719204.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719211.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719013.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719204.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719212.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719013.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719204.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719212.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719014.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719204.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719212.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719014.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719206.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719212.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719014.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719206.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719213.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719014.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719206.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719213.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719015.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719206.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719213.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719015.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719207.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719213.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719015.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719207.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719214.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719015.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719207.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719214.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719016.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719207.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719214.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719016.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719208.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719214.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719016.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719208.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719241.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719016.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719208.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719241.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719017.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719208.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719241.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719017.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719209.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719241.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719017.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719209.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719242.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719017.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719209.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719242.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719018.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719209.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719242.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719018.trim_1U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719211.trim_1P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719242.trim_2U.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719018.trim_2P.fastq.gzAligned.sortedByCoord.out.bam,sel3_SRR1719211.trim_1U.fastq.gzAligned.sortedByCoord.out.bam --softmasking --cores 1
