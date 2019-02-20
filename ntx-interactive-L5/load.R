library(ggplot2)
library(ggbeeswarm)

setwd('~/Dropbox/CODE/R scripts/ntx-interactive-L5/')

library.info <- read.csv('files/Supplementary Data 4 - Fig 1 - gene expression and library information.csv')
library.info$LibraryID <- paste(library.info$LibraryID, 'TPM',sep="_")
library.info[library.info$Reference == 'Akbari','LibraryID'] <- paste('X',library.info[library.info$Reference == 'Akbari','LibraryID'],sep="")

TPM.akbari <- read.csv('files/Supplementary Data 6 - Fig 1 - gene expression TPM Akbari NCBI Gene ID.csv')
TPM.matthews <- read.csv('files/Supplementary Data 7 - Fig 1 - gene expression TPM Matthews NCBI Gene ID.csv')
TPM.verily <- read.csv('files/Supplementary Data 8 - Fig 1 - gene expression TPM Verily NCBI Gene ID.csv')

TPM.step1 <- merge(TPM.akbari,TPM.matthews,by=c('Gene.ID','NCBI.Gene.ID','Gene.symbol'))
TPM.all <- merge(TPM.step1,TPM.verily,by=c('Gene.ID','NCBI.Gene.ID','Gene.symbol'))

elav <- c('LOC5570204','LOC5570205')
ppk <- c('LOC5564307','LOC5573846','LOC5563925','LOC5567201')
big5 <- c('LOC5572846','LOC5567058','LOC5572471','LOC5576592','LOC5567895')

# automatically generate list of libraries by library ID
an.SF <- library.info[library.info$Sex == 'F' & library.info$Tissue == 'antenna' & library.info$Condition.Timepoint == 'SF','LibraryID']

#an.SF <- c('Fe_An_SF_1_TPM','Fe_An_SF_2_TPM','Fe_An_SF_3_TPM','Fe_An_SF_4_TPM','Fe_An_SF_5_TPM','Fe_An_SF_6_TPM','Fe_An_SF_7_TPM','Fe_An_SF_8_TPM')

TPM.search.genes.lib <- function(genes,lib) {
  temp <- melt(as.matrix(TPM.all[TPM.all$Gene.symbol %in% genes,lib]))
  temp$Var1 <- TPM.akbari[temp$Var1,'Gene.symbol']
  return(temp)
}

TPM.search.genes <- function(genes)  {
  temp <- TPM.all[TPM.all$Gene.symbol %in% genes,3:length(colnames(TPM.all))]
  row.names(temp) <- temp[,1]
  temp2 <- melt(as.matrix(temp[,2:length(colnames(temp))]))
  
  return(merge(temp2,library.info,by.x = 'Var2', by.y = 'LibraryID'))
}

ppk_fe_an <- TPM.search.genes.lib(ppk,an.SF)
ppk_all <- TPM.search.genes(ppk)

big5_all <- TPM.search.genes(big5)

TPM.plot <- ggplot(ppk_all,aes(y=value+10e-3,x=as.factor(Var1))) + 
  geom_violin() + 
  geom_beeswarm(priority = 'ascending',aes(fill=Tissue))  + 
  scale_y_log10() +
  facet_grid(rows=c('Sex','Reference'))

TPM.plot <- ggplot(big5_all[big5_all$Reference =='Matthews',],aes(y=value+10e-3,x=Tissue)) + 
  geom_violin() + 
  geom_beeswarm(priority = 'ascending',aes(colour=Tissue))  + 
  scale_y_log10() +
  facet_grid(rows=c('Sex','Var1'))

TPM.plot <- ggplot(big5_all[big5_all$Reference =='Matthews',],aes(y=value+10e-3,x=Tissue)) + 
  geom_violin() + 
  geom_beeswarm(priority = 'ascending',aes(colour=Tissue))  + 
  scale_y_log10() +
  facet_grid(rows=c('Sex','Var1'))
