#!/bin/bash -l

#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J star_mapping_rna
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools
module load star/2.7.2b

# Your commands
# build genome index
# use hard mask file
# STAR --runThreadN 2 --runMode genomeGenerate --genomeChrBinNbits 18 --genomeSAindexNbases 9 --genomeDir /home/ziqi/Ziqi_Genome_Analysis/result/7_ref_mapping/Index --genomeFastaFiles /home/ziqi/Ziqi_Genome_Analysis/unziped_data/sel3_NW_015504249.fna

# read alignment
cd /home/ziqi/Ziqi_Genome_Analysis/2_Eckalbar_2016/sel3/rna_seq_data/trimmed/

for i in 242
 	do
	echo "Running Paired $i..."
        STAR --runThreadN 12 --genomeDir /home/ziqi/Ziqi_Genome_Analysis/result/7_ref_mapping/Index --readFilesIn sel3_SRR1719"$i".trim_1P.fastq.gz sel3_SRR1719"$i".trim_2P.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/ziqi/Ziqi_Genome_Analysis/result/7_ref_mapping/star_test/outputP_SRR{$i} --outSAMtype BAM SortedByCoordinate
	echo "Running unpaired $i..."
	STAR --runThreadN 12 --genomeDir /home/ziqi/Ziqi_Genome_Analysis/result/7_ref_mapping/Index --readFilesIn sel3_SRR1719"$i".trim_1U.fastq.gz,sel3_SRR1719"$i".trim_2U.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/ziqi/Ziqi_Genome_Analysis/result/7_ref_mapping/star_test/outputU_SRR{$i} --outSAMtype BAM SortedByCoordinate
	done
