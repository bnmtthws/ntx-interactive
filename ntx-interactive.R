### import the required libraries
library(ggplot2)
library(gdata)
library(reshape2)

### set your working directory
setwd('~/bioinfo/github/ntx-interactive/')

### define the relevant filenames within the working directory
ANNOTATION <- 'files/Additional file 3 - AaegLRU annotation.csv'
TPM_RU <- 'files/Additional File 5 - TPM_all.csv'
TPM_VEC <- 'files/Additional File 6 - TPM_all_AaegL3.3.csv'
LIBRARIES <- 'files/Additional File 4 - Library statistics.csv'

### read in these files
annotations <- read.csv(ANNOTATION)
tpm_ru <- read.csv(TPM_RU)
tpm_vec <- read.csv(TPM_VEC)
lib_info <- read.csv(LIBRARIES)

### concatentate condition, sex, tissue in lib_info
lib_info$state <- paste(lib_info$condition, lib_info$sex, lib_info$tissue)

### set of common columns we'll keep for all tissues
common_cols = c('Vectorbase.Identifier','Internal.gene.ID','Display.name','Gene.family')

### define the tissues we want to work with
br_bf = c('Fe_Br_BF_1','Fe_Br_BF_2','Fe_Br_BF_3','Fe_Br_BF_4')
br_sf = c('Fe_Br_SF_1','Fe_Br_SF_4','Fe_Br_SF_5','Fe_Br_SF_6','Fe_Br_SF_7')
br_o = c('Fe_Br_O_1','Fe_Br_O_2','Fe_Br_O_3','Fe_Br_O_4')


### define our gene(s) of interest
genes = c('AAEL010779','AAEL000582')

### grab our genes of interest, only within our tissue of interest
tpm_subset <- tpm_ru[tpm_ru$Vectorbase.Identifier %in% genes,colnames(tpm_ru) %in% c(common_cols,br_sf,br_bf,br_o)]

### reformat dataframe by 'melting' it for easier plotting
tpm_subset.melt <- melt(tpm_subset,id.vars = common_cols)
tpm_subset.melt['bloodfeeding.state']

### classify data by state, in addition to individual libraries
tpm_subset.melt[tpm_subset.melt$variable %in% br_sf,]$state <- 'brain sugarfed'
colnames(tpm_subset.melt)[5:6] <- c("Library.ID","Transcripts.Per.Million")

tpm_subset.melt <- merge(lib_info[,c("Library.ID","state")], tpm_subset.melt,by="Library.ID")

### generate plot using ggplot2
final_plot <- ggplot(data=tpm_subset.melt,aes(x=Vectorbase.Identifier,y=value,group=state,colour=state)) + geom_point(position=position_dodge(width = .5))
final_plot <- final_plot + ggtitle("brain expression profile")
