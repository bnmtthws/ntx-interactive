### import the required libraries
library(ggplot2)
library(gdata)
library(reshape2)

### set your working directory
setwd('~/bioinfo/github/ntx-interactive/')

### load the data behind the scenes
source('ntx-interactive-loadData.R')
source('ntx-interactive-plottingFunctions.R')

### define our gene(s) of interest
genes = c('AAEL010779','AAEL000582')
tissues = c('brain','antenna')

### examplePlot

ppkBrain <- plotData(genes,tissues)



