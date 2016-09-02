
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