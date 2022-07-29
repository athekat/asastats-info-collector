library(dplyr)
library(tidyr)
shell.exec("get-info.bat")
Sys.sleep(10)
asahistory <- read.csv("asahistory.csv") #La primera vez no se ejecuta.
asadf <- read.delim2("results.txt", header = FALSE, sep = " ", dec = ".")

asadf <- subset(asadf, select = -c(1,2,3,6,7,8,9,10))
colnames(asadf) <- c("algoprice","usd")
asadf$algoprice<- gsub("data-pricealgo=","",as.character(asadf$algoprice))
asadf$usd<- gsub("data-total=","",as.character(asadf$usd))
asadf$algoprice = as.numeric(as.character(asadf$algoprice))
asadf$usd = as.numeric(as.character(asadf$usd))
asadf$algos <- c(asadf$usd/asadf$algoprice)
asadf$date <-format(Sys.time(), "%D")
asadf <- select(asadf, date, usd, algoprice, algos)

# write.csv(asadf, "asahistory.csv", row.names=FALSE) Luego de la primera no volver a ejecutar

asahistory <- rbind(asahistory, asadf) 

write.csv(asahistory, "asahistory.csv", row.names=FALSE)

file.remove('results.txt')
file.remove('download.txt')