#install package
#install.packages('spatialEco', repos='http://cran.us.r-project.org')
#install.packages("RCurl", repos='http://cran.us.r-project.org')

#must be at least v3.4 or greater in r
#link to the docs:
#https://www.rdocumentation.org/packages/spatialEco/versions/1.1-1/topics/download.prism

#install package
#install.packages('spatialEco', repos='http://cran.us.r-project.org')
#install.packages("RCurl", repos='http://cran.us.r-project.org')

#must be at least v3.4 or greater in r
#link to the docs:
#https://www.rdocumentation.org/packages/spatialEco/versions/1.1-1/topics/download.prism

library(spatialEco)
library(RCurl)

dates1 <- c('1990/1/1', '1991/1/1', '1992/1/1',
           '1993/1/1', '1994/1/1', '1995/1/1', '1996/1/1',
           '1997/1/1')
#bash variable
PATH <- Sys.getenv("VARIABLENAME")
#dates1 90-97
for(i in dates1){
  print(i)
  download.prism('ppt', date.range=(replicate(2, i)), time.step='monthly',
                 download.folder = PATH,
                 by.year=FALSE)
}