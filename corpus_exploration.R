Needed <- c("tm", "SnowballCC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", 
            "cluster", "igraph", "fpc")
install.packages(Needed, dependencies = TRUE)

install.packages("Rcampdf", repos = "http://datacube.wu.ac.at/", type = "source")

library(tm)
getwd()
setwd("C:/Users/segutierrez/Dropbox/a_Context_Volatility/tesis-colmex/tesis_2000s")


docs <-Corpus(DirSource("/Users/segutierrez/Dropbox/a_Context_Volatility/tesis-colmex/tesis_2000s"), readerControl = list(language="lat")) 
summary(docs)
docs <- tm_map(docs,removePunctuation)   
docs <- tm_map(docs, tolower)   
docs <- tm_map(docs, PlainTextDocument)
docs <- tm_map(docs, removeWords, stopwords("spanish"))   
docs <- tm_map(docs, stripWhitespace)
writeLines(as.character(docs[1])) # Check to see if it worked.
docs <- tm_map(docs, PlainTextDocument)
