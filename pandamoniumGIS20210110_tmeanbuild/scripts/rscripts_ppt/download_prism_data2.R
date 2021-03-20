#install package
#install.packages('spatialEco', repos='http://cran.us.r-project.org')
#install.packages("RCurl", repos='http://cran.us.r-project.org')

#must be at least v3.4 or greater in r
#link to the docs:
#https://www.rdocumentation.org/packages/spatialEco/versions/1.1-1/topics/download.prism

library(spatialEco)
library(RCurl)
           
dates2 <- c('1998/1/1', '1999/1/1', '2000/1/1',
           '2001/1/1', '2002/1/1', '2003/1/1', '2004/1/1', 
           '2005/1/1' )          
#dates2 98-05
#bash variable
PATH <- Sys.getenv("VARIABLENAME")
for(i in dates2){
  print(i)
  download.prism('ppt', date.range=(replicate(2, i)), time.step='monthly',
                 download.folder = PATH,
                 by.year=FALSE)
}
