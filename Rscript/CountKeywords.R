rm(list=ls())
#setwd("~/GitHub/bioinformatics/Rscript")

library(jsonlite)
require(XLConnect)

library(tidytext)
library(magrittr)
library(readr)
library(ggplot2)
library(data.table)

load(file = "../Corpus/RNAseq_Corpus.Rdata")
startyear <- 2008
endyear <- 2016

## merge Corpus and MetaYear data
setDT(Corpus)
setDT(MetaYear)
CorpusYear <- merge(Corpus,MetaYear,by="PMC")
Corpus.u <- unique(CorpusYear, by=c("PMC", "word"))
Corpus.u[, pubYear := as.numeric(as.character(pubYear)) ]

## create ToolDT
## store a number of occurances for each search term
ToolDT <- NULL
ToolsCat <- names(Tools) 
for(i in ToolsCat) {
	tmp <- data.frame(Category=i, Tools=tolower(unlist(Tools[[i]], use.name=F)))
	ToolDT <- rbind(ToolDT, tmp)
}
setDT(ToolDT)

## create a new column `Count` to store a number of occurances
ToolDT[,Count := 0]
for(i in 1:nrow(ToolDT)) {
	print(paste("Check:",ToolDT[i,Tools]))
	ToolDT[i,Count := Corpus.u[grep(ToolDT[i,Tools], word, ignore.case=TRUE), .N]]
}

## for each category in ToolsCat, create a barplot 
for(i in ToolsCat) {
	gTool = ggplot(ToolDT[Category==i & Count > 0,],aes(x=Tools,y=Count)) + geom_bar(stat='identity') + theme_bw() + ggtitle(i) + xlab("Bioinformatic Packages") + ylab("A Number of Articles")
	ggsave(filename=paste0("figure/",gsub(" ", "", i),".jpg"),plot=gTool, width=10,height=5)
}

## create ToolDTYear
## store a number of occurances for each search term, for each publication year
Corpus.u[,Matched := 0]
ToolDTYear <- ToolDT
ToolDTYear <- ToolDTYear[, cbind(Year=unique(Corpus.u$pubYear), .SD), by="Tools"]
for(i in 1:nrow(ToolDT)) {
		print(paste("Check:",ToolDT[i,Tools]))
		Corpus.u[,Matched := grepl(ToolDT[i,Tools], Corpus.u$word, ignore.case=TRUE)]
		for(j in startyear:endyear){
			ToolDTYear[Year == j & Tools == ToolDT[i,Tools], Count := Corpus.u[pubYear == j, sum(Matched)]]
		}
}

## generate and save a plot, e.g., for tools in the 'Quality Control' category
ggplot(ToolDTYear[Category == "Quality Control" & Count > 0], aes(x=Year, y=Count, group=Tools)) + theme_bw() +
geom_point(aes(colour = Tools)) + geom_line(aes(colour = Tools)) + ggtitle("Temporal Trend of Quality Control Tools")
ggsave(filename=paste0("figure/TemporalTrends_QualityControl.jpg"), width=7,height=5)

save(ToolDT, ToolDTYear, Corpus.u, file="../Corpus/RNAseq_Corpus_Processed.Rdata")
