#install.packages("httr")
install.packages("devtools")
install.packages("xlsx")
library(xlsx)

#THOUGHT I WOULD NEED, but didn't
#devtools::install_github("r-lib/httr")
#install.packages("tldextract")
#library(tldextract)
#library("httr")
#install.packages("urltools")
#library("urltools")


#install.packages("stringr")
library("stringr")



getwd()
#Windows
#setwd("/Users/segutierrez/Dropbox/a_Context_Volatility")
#Ubuntu
setwd("/home/luba/Dropbox/a_Context_Volatility")




ciencias2 <- read.table('ciencias_separador_barra.csv', sep = '|', header = TRUE, fill=TRUE, encoding = "UTF-8", stringsAsFactors=FALSE)
ciencias1 <- read.table('ciencias.csv', sep = ',', header = TRUE, fill=TRUE, encoding = "UTF-8", stringsAsFactors=FALSE)

dim(ciencias1)
# dimensiones con comas: 295  67
dim(ciencias2)
# dimensiones con barras: 297  67

x = "Mal¬|k124412"
str_replace_all(x, "[^[:alnum:]]", " ")

dim(humanidades)
#506  72



humanidades <- read.table('humanidades.csv', sep = ',', header = TRUE, fill=TRUE, encoding = "UTF-8", stringsAsFactors=FALSE)

View(ciencias)
c2 <- read.xlsx("ciencias_menos_columna.xlsx", sheetName = "test", encoding="UTF-8")
dim(c2)
#2021   40
 

df = read.table("clipboard", fill=TRUE, encoding ="UTF-8")
dim(df)
View(df)
View(ciencias)
summary(ciencias)

dfciencias <- data.frame(ciencias)
View(dfciencias)

#Seleccionar columnas útiles
data <- dfciencias[,c("title1","creator1name","publishDate1","publisher1","repoName","resourceIdentifier1","contributor1name","contributor1role","subject1key","subject1value","subject2key","subject2value","subject3key","subject3value","subject4key","subject4value")]

#Obtener los "paths" de los diferentes namespaces
data$subjectkey1 <- dirname(data$subject1key)
data$subjectkey2 <- dirname(data$subject2key)
data$subjectkey3 <- dirname(data$subject3key)
data$subjectkey4 <- dirname(data$subject4key)

#Sacar frecuencias de cada una de las columnas
freqciencias = data.frame()

for (i in 1:ncol(data)){
  
  dt_temp = data.frame(t(table(data[,i])))
  dt_temp$Var1 = names(data)[i]
  
  freqciencias = rbind(freqciencias, dt_temp)
  
}

names(freqciencias) = c("Variable","Levels","Freq")

View(freqciencias)

View(data)


write.xlsx(freqciencias, "freqciencias.xlsx", row.names=FALSE)
write.xlsx(data, "ciencias_clean.xlsx", row.names=FALSE)

write.csv(freqciencias, "freqciencias.csv", row.names=FALSE)

#suffix_extract(domain(ciencias$subject2key[1]))
#write.csv(data, "ciencias_clean_UTF8.csv", row.names=FALSE)
