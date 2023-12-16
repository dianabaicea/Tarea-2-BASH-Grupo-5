
args_script <- commandArgs(trailingOnly = T)
res_dir <- as.character(args_script[[1]])
print (res_dir)
ins_dir <- as.character(args_script[[2]])
print (ins_dir)
tf_em <- as.character(args_script[[3]])
print(tf_em)

## Loading packages
library(ChIPseeker)
library(TxDb.Athaliana.BioMart.plantsmart28)
library(clusterProfiler)
library(org.At.tair.db)
library(enrichplot)
library(pathview)

## Save the annotation of the transcription for a genome 
txdb <- TxDb.Athaliana.BioMart.plantsmart28  

## Determination of the peak file created used in the process if it is a transcription factor or epigenetic marks. 
if(tf_em == "tf") {
  peaks <- readPeakFile(peakfile = "finalpeak.narrowPeak",header=FALSE)
   }else {
    peaks <- readPeakFile(peakfile = "finalpeak.broadPeak",header=FALSE)
  }

## Determination of the promoter region, which is around the TSS 
promoter <- getPromoters(TxDb=txdb, 
                         upstream=1000, 
                         downstream=1000)

## Peak's annotation 
peakAnno <- annotatePeak(peak = peaks, 
                              tssRegion=c(-1000, 1000),
                              TxDb=txdb, annoDb = "org.At.tair.db")
## Creation of plots
png ("pie_plot.png")
plotAnnoPie(peakAnno, main="Genic regions") 
dev.off()

png ("bar_plot.png")
plotAnnoBar(peakAnno, main="Genic regions")
dev.off()

png ("TSS_plot.png")
plotDistToTSS(peakAnno,
              title="Distribution of genomic loci relative to TSS",
              ylab = "Genomic Loci (%) (5' -> 3')")
dev.off()

## Annotation converted into data frame
peaks.annotation <- as.data.frame(peakAnno)
head(peaks.annotation)

target.genes <- peaks.annotation$geneId[peaks.annotation$annotation == "Promoter"]

write(x = target.genes,file = "target_genes.txt")

## Gene Ontology enrichment analysis
enrich.go <- enrichGO(gene = target.genes,
                           OrgDb         = org.At.tair.db,
                           ont           = "BP", 
                           pAdjustMethod = "BH", 
                           pvalueCutoff  = 0.05, 
                           readable      = FALSE, 
                           keyType = "TAIR")

##Creation of plots
png("bar_plot_enrich.png")
barplot(enrich.go,showCategory = 9) 
dev.off()

png("dot_plot_enrich.png")
dotplot(enrich.go,showCategory = 9)
dev.off()

png("emap_plot_enrich.png")
emapplot(pairwise_termsim(enrich.go),showCategory = 15, cex_label_category = 0.5)
dev.off()

png("cnet_plot.png")
cnetplot(enrich.go,showCategory = 7, cex_label_category = 0.5) 
dev.off()

## Functional enrichment analysis on biological pathways
enrich.kegg <- enrichKEGG(gene=unique(target.genes),
                               organism = "ath",
                               keyType = "kegg",
                               pAdjustMethod = "BH",
                               pvalueCutoff  = 0.05)

df.enrich.kegg <- as.data.frame(enrich.kegg)
head(df.enrich.kegg)

if(nrow(df.enrich.kegg) == 0)
{
  print("No functional enrichment of KEGG terms on biological pathaways detected.")
} else
{
  for (i in 1:nrow(df.enrich.kegg))
  {
    pathway.id <- df.enrich.kegg$ID[i]
    pathview(gene.data=target.genes, pathway.id=pathway.id, species = "ath",
    gene.idtype="TAIR", kegg.dir="kegg_images/")
  }
  write.table(x = df.enrich.kegg, file = "enrich_kegg.csv", sep = ";")
  print("The enrichment of KEGG terms on biological pathways detected were written in the enrich_kegg.csv file created")
  
}




