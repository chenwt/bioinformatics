require(XLConnect)
wb <- loadWorkbook("RNASeq_Tools.xlsx")
lst = readWorksheet(wb, sheet = getSheets(wb)[-1], startRow=1, header=FALSE)

for(i in getSheets(wb)[-1]) {
  fname = gsub(" ","",i)
  write.csv(lst[[i]], row.names=FALSE, col.names=NA, file=paste0("csv/",fname,".csv"))
}