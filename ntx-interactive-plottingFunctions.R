
plotData <- function(genes, tissues) {
  
  ### grab our genes of interest, only within our tissue of interest
  tpm_subset <- tpm_ru[tpm_ru$Vectorbase.Identifier %in% genes,]
  
  ### reformat dataframe by 'melting' it for easier plotting
  tpm_subset.melt <- melt(tpm_subset,id.vars = common_cols)
  
  ### classify data by state, in addition to individual libraries
  colnames(tpm_subset.melt)[5:6] <- c("Library.ID","Transcripts.Per.Million")
  
  tpm_subset.melt <- merge(lib_info[,c("Library.ID","tissue","state","sex")], tpm_subset.melt,by="Library.ID")
  
  ### generate plot using ggplot2
  final_plot <- ggplot(data=tpm_subset.melt[tpm_subset.melt$tissue %in% tissues,],
                       aes(x=Vectorbase.Identifier,y=Transcripts.Per.Million,
                           group=state,colour=state)) + 
    geom_point(position=position_dodge(width = .5)) +
    facet_grid(sex ~ tissue)
  final_plot <- final_plot + ggtitle("expression profile")
  
  return(final_plot)
}