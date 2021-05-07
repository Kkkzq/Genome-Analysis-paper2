#!/bin/bash -l

#SBATCH -A g2021012 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 06:00:00
#SBATCH -J star_mapping_rna
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools 
module load star/2.7.2b

# Your commands
# build genome index
# use hard mask file
# STAR --runThreadN 2 --runMode genomeGenerate --genomeChrBinNbits 9 --genomeSAindexNbases 12 --genomeDir /home/ziqi/Ziqi_Genome_Analysis/result/7_rna_mapping/index --genomeFastaFiles /home/ziqi/Ziqi_Genome_Analysis/result/6_repeatmasker/hardmask/closed_gaps.fasta.masked

# read alignment
# cs15
# forelimb
cd /home/ziqi/Ziqi_Genome_Analysis/2_Eckalbar_2016/sel3/rna_seq_data/trimmed/

for i in ./*fastq.gz
	do
	echo "running $i"
	STAR --runThreadN 12 --genomeDir /home/ziqi/Ziqi_Genome_Analysis/result/7_rna_mapping/index --readFilesIn $i --readFilesCommand zcat --outFileNamePrefix /home/ziqi/Ziqi_Genome_Analysis/result/7_rna_mapping/star/"$i" --outSAMtype BAM SortedByCoordinate
	done
