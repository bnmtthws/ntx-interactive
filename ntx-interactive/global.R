##### LOAD DATA FOR NTX PLOTTING

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

plotData <- function(genes, tissues) {
  
  ### grab our genes of interest, only within our tissue of interest
  tpm_subset <- tpm_ru[tpm_ru$Vectorbase.Identifier %in% genes,]
  
  ### reformat dataframe by 'melting' it for easier plotting
  tpm_subset.melt <- melt(tpm_subset,id.vars = common_cols)
  
  ### classify data by state, in addition to individual libraries
  colnames(tpm_subset.melt)[5:6] <- c("Library.ID","Transcripts.Per.Million")
  
  tpm_subset.melt <- merge(lib_info[,c("Library.ID","tissue","state","sex","condition")], tpm_subset.melt,by="Library.ID")
  
  tpm_subset.melt$condition <- revalue(tpm_subset.melt$condition, c("SF"="Sugarfed_0h", "BF"="Bloodfed_48h","O"="Gravid_96h","male"="Male"))  
  tpm_subset.melt$condition <- factor(tpm_subset.melt$condition, c("Sugarfed_0h", "Bloodfed_48h", "Gravid_96h", "male"))
  
  ### generate plot using ggplot2
  final_plot <- ggplot(data=tpm_subset.melt[tpm_subset.melt$tissue %in% tissues,],
                       aes(x=Vectorbase.Identifier,y=Transcripts.Per.Million,
                           group=condition,colour=condition)) + 
    geom_point(position=position_dodge(width = .5)) +
    facet_grid(sex ~ tissue)
  final_plot <- final_plot + ggtitle("expression profile")
  
  return(final_plot)
}

plotDataRU <- function(genes, tissues) {
  
  ### grab our genes of interest, only within our tissue of interest
  tpm_subset <- tpm_ru[tpm_ru$Internal.gene.ID %in% genes,]
  
  ### reformat dataframe by 'melting' it for easier plotting
  tpm_subset.melt <- melt(tpm_subset,id.vars = common_cols)
  
  ### classify data by state, in addition to individual libraries
  colnames(tpm_subset.melt)[5:6] <- c("Library.ID","Transcripts.Per.Million")
  
  tpm_subset.melt <- merge(lib_info[,c("Library.ID","tissue","state","sex","condition")], tpm_subset.melt,by="Library.ID")
  
  tpm_subset.melt$condition <- revalue(tpm_subset.melt$condition, c("SF"="Sugarfed_0h", "BF"="Bloodfed_48h","O"="Gravid_96h","male"="Male"))  
  tpm_subset.melt$condition <- factor(tpm_subset.melt$condition, c("Sugarfed_0h", "Bloodfed_48h", "Gravid_96h", "male"))
  
  ### generate plot using ggplot2
  final_plot <- ggplot(data=tpm_subset.melt[tpm_subset.melt$tissue %in% tissues,],
                       aes(x=Internal.gene.ID,y=Transcripts.Per.Million,
                           group=condition,colour=condition)) + 
    geom_point(position=position_dodge(width = .5)) +
    facet_grid(sex ~ tissue)
  final_plot <- final_plot + ggtitle("expression profile")
  
  return(final_plot)
}