#install package
#install.packages('spatialEco', repos='http://cran.us.r-project.org')
#install.packages("RCurl", repos='http://cran.us.r-project.org')

#must be at least v3.4 or greater in r
#link to the docs:
#https://www.rdocumentation.org/packages/spatialEco/versions/1.1-1/topics/download.prism

library(spatialEco)
library(RCurl)
           
dates3 <- c('2006/1/1', '2007/1/1', '2008/1/1',
           '2009/1/1', '2010/1/1', '2011/1/1', '2012/1/1')

#bash variable
PATH <- Sys.getenv("VARIABLENAME")
#dates3 06-12
for(i in dates3){
  print(i)
  download.prism('ppt', date.range=(replicate(2, i)), time.step='monthly',
                 download.folder = PATH,
                 by.year=FALSE)
}