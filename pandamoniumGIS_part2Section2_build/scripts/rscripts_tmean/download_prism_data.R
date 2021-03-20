#install package
#install.packages('spatialEco', repos='http://cran.us.r-project.org')
#install.packages("RCurl", repos='http://cran.us.r-project.org')

#must be at least v3.4 or greater in r
#link to the docs:
#https://www.rdocumentation.org/packages/spatialEco/versions/1.1-1/topics/download.prism

library(spatialEco)
library(RCurl)

#doesn't work on 2015-2018
dates <- c('1981/1/1', '1982/1/1', '1983/1/1', '1984/1/1', 
           '1985/1/1', '1986/1/1', '1987/1/1', '1988/1/1',
           '1989/1/1')           
           #dates 81-89
PATH <- Sys.getenv("VARIABLENAME2")
print(PATH)
for(i in dates){
  print(i)
  download.prism('tmean', date.range=(replicate(2, i)), time.step='monthly',
                 download.folder = PATH,
                 by.year=FALSE)
}