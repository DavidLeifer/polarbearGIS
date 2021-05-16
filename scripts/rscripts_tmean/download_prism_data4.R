#install package
#install.packages('spatialEco', repos='http://cran.us.r-project.org')
#install.packages("RCurl", repos='http://cran.us.r-project.org')

#must be at least v3.4 or greater in r
#link to the docs:
#https://www.rdocumentation.org/packages/spatialEco/versions/1.1-1/topics/download.prism

library(spatialEco)
library(RCurl)
           
dates4 <- c('2013/1/1', '2014/1/1', '2015/1/1', '2016/1/1',
           '2017/1/1', '2018/1/1')
PATH <- Sys.getenv("VARIABLENAME")
PATH_WALKER <- paste(PATH, '/data/tmean/',sep="")
print(PATH_WALKER)
for(i in dates){
  print(i)
  download.prism('tmean', date.range=(replicate(2, i)), time.step='monthly',
                 download.folder = PATH_WALKER,
                 by.year=FALSE)
}