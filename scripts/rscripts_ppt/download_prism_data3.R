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

PATH <- Sys.getenv("VARIABLENAME")
PATH_WALKER <- paste(PATH, '/data/ppt/',sep="")
print(PATH_WALKER)
for(i in dates){
  print(i)
  download.prism('tmean', date.range=(replicate(2, i)), time.step='monthly',
                 download.folder = PATH_WALKER,
                 by.year=FALSE)
}