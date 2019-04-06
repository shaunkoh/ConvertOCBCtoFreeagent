#get file path from finder dialog
inputfilepath <- file.choose()

#get file name from file path
inputfilename <- basename(inputfilepath)

#set working directory from file path
setwd(dirname(inputfilepath))

#read CSV file
Input.Bank.Statement  <- read.csv(inputfilepath,header=TRUE)

Temp.sub <- Input.Bank.Statement[, c(8, 14, 15,18)]


#recognise dates, output in required date format
Temp.sub[,c(1)] <- format(as.Date(as.character(Temp.sub[,c(1)]), "%Y%m%d"), "%d/%m/%Y")

#create new column for transaction (credit-debit)
Temp.sub[,c(5)] <- Temp.sub[,c(3)]-Temp.sub[,c(2)]

#create subset of StatementDate, Info, TransactionAmount
Temp.sub <- Temp.sub[, c(1,4,5)]

#rearrange column order
Temp.sub <- Temp.sub[c(1,3,2)]

outputfilename <- paste("Output", inputfilename, sep=" ")

#createCSV
write.table(Temp.sub, file = outputfilename, sep=",", col.names=FALSE, row.names=FALSE)
