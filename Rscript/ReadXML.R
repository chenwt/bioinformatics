rm(list=ls())
#setwd("~/GitHub/bioinformatics/Rscript")

library(jsonlite)
require(XLConnect)

library(tidytext)
library(magrittr)
library(dplyr)
library(plyr)
library(readr)
library(ggplot2)
library(data.table)

wb <- loadWorkbook("../SoftwareList/RNASeq_Tools.xlsx")
Tools <- readWorksheet(wb, sheet = getSheets(wb)[-1], startRow=1, header=FALSE)

PaperDirs <- list.dirs(path = "../Corpus/RNAseq", full.names = FALSE, recursive = TRUE)
PaperDirs <- sort(PaperDirs) 
PaperDirs <- PaperDirs[-c(1)]

Corpus <- NULL
Meta <- NULL
for(i in 1:length(PaperDirs)) {
  cat(i)
  ## import each XML file and parse them into a data frame consisted of individual words
  PaperTmp <- data_frame(PMC=PaperDirs[i], text = read_lines(paste0("../Corpus/RNAseq/", PaperDirs[i], "/fulltext.xml"))[2]) %>%
                 unnest_tokens(word, text, token = "words", format = "text")
  ## format = "xml" takes too long
  Corpus <- rbind(Corpus, PaperTmp)

  ## import each JSON file
  MetaTmp <- fromJSON(paste0("../Corpus/RNAseq/", PaperDirs[i], "/eupmc_result.json"))
  MetaTmp <- as.data.frame(MetaTmp)
  MetaTmp$PMC <- PaperDirs[i]
  Meta <- rbind.fill(Meta, MetaTmp)
}

#length(unique(Corpus$PMC[Corpus$PMC %in% Meta$PMC])) == nrow(Meta)
MetaYear <- Meta[, c("PMC","pubYear")]

save(Tools, PaperDirs, Corpus, Meta, MetaYear file="../Corpus/RNAseq_Corpus.Rdata")