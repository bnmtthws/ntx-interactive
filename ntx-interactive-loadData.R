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

### define the tissues we want to work with
br_bf = c('Fe_Br_BF_1','Fe_Br_BF_2','Fe_Br_BF_3','Fe_Br_BF_4')
br_sf = c('Fe_Br_SF_1','Fe_Br_SF_4','Fe_Br_SF_5','Fe_Br_SF_6','Fe_Br_SF_7')
br_o = c('Fe_Br_O_1','Fe_Br_O_2','Fe_Br_O_3','Fe_Br_O_4')