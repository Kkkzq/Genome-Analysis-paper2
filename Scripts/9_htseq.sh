#!/bin/bash -l

#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J htseq_count
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools
module load samtools/1.12
module load htseq/0.12.4

# Your Command
# cd /domus/h1/ziqi/Ziqi_Genome_Analysis/result/8_ref_annotation/new_bamfile
# forlimb_cs15
# samtools merge forlimb_cs15.bam outputP_SRR{013}Aligned.sortedByCoord.out.bam outputP_SRR{014}Aligned.sortedByCoord.out.bam outputP_SRR{015}Aligned.sortedByCoord.out.bam
# forlimb_cs16
# samtools merge forlimb_cs16.bam outputP_SRR{204}Aligned.sortedByCoord.out.bam outputP_SRR{206}Aligned.sortedByCoord.out.bam outputP_SRR{207}Aligned.sortedByCoord.out.bam
# forlimb_cs17
# samtools merge forlimb_cs17.bam outputP_SRR{208}Aligned.sortedByCoord.out.bam outputP_SRR{209}Aligned.sortedByCoord.out.bam outputP_SRR{211}Aligned.sortedByCoord.out.bam
# hindlimb_cs15
# samtools merge hindlimb_cs15.bam outputP_SRR{016}Aligned.sortedByCoord.out.bam outputP_SRR{017}Aligned.sortedByCoord.out.bam outputP_SRR{018}Aligned.sortedByCoord.out.bam
# hindlimb_cs16
# samtools merge hindlimb_cs16.bam outputP_SRR{212}Aligned.sortedByCoord.out.bam outputP_SRR{242}Aligned.sortedByCoord.out.bam outputP_SRR{214}Aligned.sortedByCoord.out.bam
# hindlimb_cs17
# samtools merge hindlimb_cs17.bam outputP_SRR{213}Aligned.sortedByCoord.out.bam outputP_SRR{241}Aligned.sortedByCoord.out.bam outputP_SRR1719266Aligned.sortedByCoord.out.bam

# move merged bam files into 9_htseq folder

cd /domus/h1/ziqi/Ziqi_Genome_Analysis/result/9_htseq
for i in *.bam
do
    echo "running $i"
    htseq-count -f bam -s no -t gene -i ID $i NW_015504249.1.gff > htseq_count_$i.txt
done

