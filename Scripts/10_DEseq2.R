library(data.table)
library(matrixStats)
library(stats)
library(gplots)
library(DESeq2) # Use BiocManager to install this package
library(ggplot2)
library(RColorBrewer)
library(pheatmap)

# Read HTseq data files
setwd("D:/个人资料/UU/课程材料/T2p2/Genome Analysis/lab-github/Results/9_htseq")

cs15_fore <- read.table("htseq_count_forlimb_cs15.bam.txt", head=FALSE)
cs15_hind <- read.table("htseq_count_hindlimb_cs15.bam.txt", head=FALSE)
cs16_fore <- read.table("htseq_count_forlimb_cs16.bam.txt", head=FALSE)
cs16_hind <- read.table("htseq_count_hindlimb_cs16.bam.txt", head=FALSE)
cs17_fore <- read.table("htseq_count_forlimb_cs17.bam.txt", head=FALSE)
cs17_hind <- read.table("htseq_count_hindlimb_cs17.bam.txt", head=FALSE)

# Rename heads
names(cs15_fore)[2] <- "FL_15"
names(cs15_hind)[2] <- "HL_15"
names(cs16_fore)[2] <- "FL_16"
names(cs16_hind)[2] <- "HL_16"
names(cs17_fore)[2] <- "FL_17"
names(cs17_hind)[2] <- "HL_17"

# Merge dataframe
countData <- merge(cs15_fore,cs15_hind,by="V1")
countData <- merge(countData,cs16_fore,by="V1")
countData <- merge(countData,cs16_hind,by="V1")
countData <- merge(countData,cs17_fore,by="V1")
countData <- merge(countData,cs17_hind,by="V1")

# Rename head
names(countData)[1] <- "Gene"

# Delete unwanted information
# _alignment_not_unique etc.
countData <- countData[-c(1,2,3,4,5),]
countData <- data.frame(row.names =countData[,1], FLCS15=countData[2], FLCS16=countData[3], FLCS17=countData[4], HLCS15=countData[5], HLCS16=countData[6], HLCS17=countData[7])

# load gene names
genename <- read.table("genename.txt", header = FALSE)
(setattr(countData, "row.names", c(genename[,2])))

# prepare for DEseq2 analysis
count_for_deseq2 <- countData
count_for_deseq2=count_for_deseq2[c("FL_15","HL_15","FL_16","HL_16","FL_17","HL_17")]
deseq2.matrix <- as.matrix(count_for_deseq2)

# remove zero values
countData <- countData[apply(countData[c(1,4)], 1, function(x) !all(x==0)),]
countData=countData[c("FL_15","HL_15","FL_16","HL_16","FL_17","HL_17")]
countData.matrix <- as.matrix(countData)


##### These codes for heatmap are decided not to use
##### But I still keep them here

# prepare for heatmap
# zScoreMatrix <- (countData.matrix-rowMeans(countData.matrix))/(rowSds(as.matrix(countData.matrix)))[row(countData.matrix)]
# row.clus <-hclust(dist(countData))
# scaleBWR <- colorRampPalette(c("blue","white","red"), space="rgb")(10)

#draw heatmap
# par(mar=c(1,1,1,1))
# heatmap.2(zScoreMatrix, Rowv = as.dendrogram(row.clus), col=scaleBWR, density.info = "none", trace = "none", margins = c(7,10))




############   DEseq2 

# prepare for deseq2 dds matrix
cts = deseq2.matrix
condition = factor(c(1,1,2,2,3,3), levels = c(1, 2, 3), labels = c("cs15", "cs16", "cs17"))
type = factor(c(1, 2, 1, 2, 1, 2), levels = c(1, 2), labels = c("forelimb","hindlimb"))
metadata <- data.frame(condition, type)
# metadata <- matrix(c("cs15","forelimb","cs15","hindlimb","cs16","forelimb","cs16","hindlimb","cs17","forelimb","cs17","hindlimb"),ncol=2,byrow=TRUE)
# colnames(metadata) <- c("condition", "type")
rownames(metadata) <- c("FL_15","HL_15","FL_16","HL_16","FL_17","HL_17")

# compare limbs
# build dds matrix
dds_limbs <- DESeqDataSetFromMatrix(countData = cts,
                              colData = metadata,
                              design = ~ type)
# run analysis
dds_limbs <- DESeq(dds_limbs)
# results extracts a result table
res_limbs <- results(dds_limbs, contrast = c("type", "forelimb", "hindlimb"))
resultsNames(dds_limbs)
# LFC shrinkage
reslfc = lfcShrink(dds_limbs, coef = "type_hindlimb_vs_forelimb", type = "apeglm")
# order the result
res_limbs_Ordered <- res_limbs[order(res_limbs$pvalue),]
# output result into file
write.csv(as.data.frame(res_limbs_Ordered), file="HL_FL_deseq2_results.csv")

### output subset with adjusted p-val < 0.01
sub_res_limbs <- subset(res_limbs_Ordered, padj <0.01)
write.csv(as.data.frame(sub_res_limbs), file="HL_FL_deseq2_results_pval0.01.csv")

summary(res_limbs)
# out of 40 with nonzero total read count
# adjusted p-value < 0.1
# LFC > 0 (up)       : 1, 2.5%
# LFC < 0 (down)     : 1, 2.5%
# outliers [1]       : 0, 0%
# low counts [2]     : 0, 0%
# (mean count < 0)

# plot
par(mfrow = c(1,2))
plotMA(res_limbs, main = "plot of res_limbs")
plotMA(reslfc, main = "plot of reslfc")
# idx <- identify(res_limbs$baseMean, res_limbs$log2FoldChange) # will stuck
# rownames(res_limbs)[idx]

# plot for gene which has the lowest p-value
p_limbs <- plotCounts(dds_limbs, gene=which.min(res_limbs$padj), intgroup="type", returnData = TRUE)
ggplot(p_limbs, aes(x=type, y=count)) + 
  geom_point(position=position_jitter(w=0.1,h=0)) + 
  scale_y_log10(breaks=c(100, 1000, 5000, 10000, 15000))
ggsave("gene with the smallest p value in limbs.png", dpi=300, height = 3, width = 4)
dev.off()

png("limbs with gene name.png", height = 400, width = 600, res=100)
plotCounts(dds_limbs, gene=which.min(res_limbs$padj), intgroup="type")
dev.off()

# PCA plot
vsd = varianceStabilizingTransformation(dds_limbs)
png("PCA for limbs.png", height = 600, width = 800, res=150)
plotPCA(vsd, intgroup=c("type"))
dev.off()



############# compare Stages and limb

# build dds matrix
dds_all <- DESeqDataSetFromMatrix(countData = cts,
                              colData = metadata,
                              design = ~ condition + type)
# run analysis
dds_all <- DESeq(dds_all)

# check the results
res_all <- results(dds_all)
resultsNames(dds_all)
# [1] "Intercept"                 "condition_cs16_vs_cs15"   
# [3] "condition_cs17_vs_cs15"    "type_hindlimb_vs_forelimb"

res_lfc_hl_fl = lfcShrink(dds_all, coef = "type_hindlimb_vs_forelimb", type = "apeglm")
res_lfc_cs15_cs16 = lfcShrink(dds_all, coef = "condition_cs16_vs_cs15", type = "apeglm")
res_lfc_cs15_cs17 = lfcShrink(dds_all, coef = "condition_cs17_vs_cs15", type = "apeglm")

# output as file
resOrdered_all <- res_all[order(res_all$pvalue),]
write.csv(as.data.frame(resOrdered_all), file="Deseq2_all_results.csv")
### output subset with adjusted p-val < 0.01
sub_res_all <- subset(resOrdered_all, padj <0.01)
write.csv(as.data.frame(sub_res_all), file="Deseq2_all_results_pval0.01.csv")

summary(res_all)
# out of 40 with nonzero total read count
# adjusted p-value < 0.1
# LFC > 0 (up)       : 5, 12%
# LFC < 0 (down)     : 9, 22%
# outliers [1]       : 0, 0%
# low counts [2]     : 0, 0%
# (mean count < 0)

# draw figures
par(mfrow = c(2,2))
plotMA(res_all, main = "plot of res_all")
plotMA(res_lfc_hl_fl, main = "plot of res_lfc_hl_fl")
plotMA(res_lfc_cs15_cs16, main = "plot of res_lfc_cs15_cs16")
plotMA(res_lfc_cs15_cs17, main = "plot of res_lfc_cs15_cs17")

# find the gene with the smallest p value
p<- plotCounts(dds_all, gene=which.min(res_all$padj), intgroup="condition", returnData = TRUE)

ggplot(p, aes(x=condition, y=count)) + 
  geom_point(position=position_jitter(w=0.1,h=0)) + 
  scale_y_log10(breaks=c(100, 1000, 5000))
ggsave("gene with the smallest p value in DEseq_all.png", dpi=300, height = 3, width = 4)
dev.off()

# with gene name
png("DESEQ_all gene name.png", height = 400, width = 600, res=100)
plotCounts(dds_all, gene=which.min(res_all$padj), intgroup="condition")
dev.off()

# PCA plot
vsd_all = varianceStabilizingTransformation(dds_all)

pcaData <- plotPCA(vsd_all, intgroup=c("condition", "type"), returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(PC1, PC2, color=condition, shape=type)) +
  geom_point(size=3) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  coord_fixed()
ggsave("PCA of DEseq_all.png", dpi=600)
dev.off()

# draw heatmap
select <- order(rowMeans(counts(dds_all,normalized=TRUE)),
                decreasing=TRUE)[1:30]
df <- as.data.frame(colData(dds_all)[,c("condition","type")])
ann_colors = list(
  condition = c(cs15 = "#f5e4e4", cs16 = "#D07A7A", cs17 = "firebrick"),
  type = c(forelimb = "#1B9E77", hindlimb = "#D95F02")
)

pheatmap(assay(vsd_all)[select,], 
         cluster_rows=TRUE, 
         show_rownames=TRUE,
         cluster_cols=FALSE,
         border=FALSE,
         fontsize = 9, 
         annotation_colors = ann_colors,
         annotation_col=df,
         filename = "Heatmap of all genes labeled.png")


# heatmap over all genes
zScoreMatrix_dev <- (cts-rowMeans(cts))/(rowSds(as.matrix(cts)))[row(cts)]
zScoreMatrix_dev <- na.omit(zScoreMatrix_dev)

pheatmap(zScoreMatrix_dev, 
         cluster_rows=TRUE, 
         show_rownames=TRUE,
         border=FALSE, 
         fontsize = 9, 
         cluster_cols=FALSE,
         filename = "Heatmap of all genes.png")

# heatmap of distance matrix
sampleDists <- dist(t(assay(vsd_all)))
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd_all$condition, vsd_all$type, sep="-")
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)

pheatmap(sampleDistMatrix,
         main = "Heatmap of distance matrix",
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         cellwidth = 30, cellheight = 24, 
         border=FALSE,
         fontsize = 8, 
         col=colors,
         filename = "Heatmap of distance matrix.png")

### Print important genes with p-val < 0.01
# genes important between fore- and hindlimb
rownames(res_limbs)[res_limbs$padj<0.01]
# [1] NA             NA             "PITX1"        NA             "LOC107525399"
# genes important between development stages
rownames(res_all)[res_all$padj<0.01]
# [1] "TGFBI"        NA             NA             "PITX1"       
# [5] "PCBD2"        "LOC107525383" "SEC24A"       "UBE2B"       
# [9] NA             "LOC107525399" "ZCCHC10"

