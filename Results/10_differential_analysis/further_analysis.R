# library packages for transfer gene id
library(devtools)
library(biomaRt)
listMarts()

ensembl=useMart("ensembl")
listDatasets(ensembl) # check gene sets, choose mlucifugus_gene_ensembl (microbat)
ensembl = useDataset("mlucifugus_gene_ensembl",mart=ensembl)
mart = useMart("ensembl",dataset="mlucifugus_gene_ensembl")

# input geneid from DEseq2 result
setwd("D:/个人资料/UU/课程材料/T2p2/Genome Analysis/lab-github/Results/10_differential_analysis")
DEseq_data <- read.csv("Deseq2_all_results.csv",header=T,sep=",")
gene <- read.csv("Deseq2_all_results.csv",header=T,sep=",")[,1]

ensbl_id <- getBM(attributes = c("hgnc_symbol", "ensembl_gene_id", "entrezgene_id"), 
      filters = "hgnc_symbol",
      values = gene,
      mart = ensembl)

# prepare for GO analysis
BiocManager::install("clusterProfiler")
library(clusterProfiler)
BiocManager::install("DOSE")
require(DOSE)
library(DO.db)
library(GO.db)
library(topGO)

BiocManager::install("org.Ss.eg.db")
library(org.Ss.eg.db)
library(org.Mm.eg.db)


ego.BP <- enrichGO(gene = ensbl_id[,3],OrgDb = org.Mm.eg.db, keyType = "ENSEMBL", ont = "BP")
# ego.MF <- enrichGO(gene = ensbl_id[,2],OrgDb = org.Ss.eg.db, ont = "MF")

# Visualization
ggplot(data=ego.BP)+
  geom_bar(aes(x=reorder(Term,Count),y=Count, fill=-log10(PValue)), stat='identity') +
  coord_flip() +
  scale_fill_gradient(expression(-log["10"](P.value)),low="red", high = "blue") +
  xlab("") +
  ylab("Gene count") +
  scale_y_continuous(expand=c(0, 0))+
  theme(
    axis.text.x=element_text(color="black",size=rel(1.5)),
    axis.text.y=element_text(color="black", size=rel(1.6)),
    axis.title.x = element_text(color="black", size=rel(1.6)),
    legend.text=element_text(color="black",size=rel(1.0)),
    legend.title = element_text(color="black",size=rel(1.1))
    # legend.position=c(0,1),legend.justification=c(-1,0)
    # legend.position="top",
  )
