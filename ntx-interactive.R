### import the required libraries
library(ggplot2)
library(reshape2)
library(plyr)

### set your working directory to the github repository home directory
setwd('~/bioinfo/github/ntx-interactive/')

### load the data behind the scenes
source('ntx-interactive-loadData.R')
source('ntx-interactive-plottingFunctions.R')

### examplePlot
### define our gene(s) of interest
genes = c('AAEL010779','AAEL000582')
tissues = c('brain','antenna')

### call function to generate plot
ppkBrainAntenna <- plotData(genes,tissues)
show(ppkBrainAntenna)

### example of interactive calling from the command line
elavBrainAntenna <- plotData("AAEL008164",c("brain","antenna"))


