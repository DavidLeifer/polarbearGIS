#https://statnmap.com/2018-01-27-spatial-correlation-between-rasters/
#install.packages('raster', repos='http://cran.us.r-project.org')
#install.packages("gstat", repos='http://cran.us.r-project.org')


library(raster) 
library(spatialEco)

raster1 <- raster("/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/panda_testing/pandamoniumGIS/data/test.tif")
raster2 <- raster('/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/panda_testing/pandamoniumGIS/data/ppt_bil2tif_resize/ppt_bil2tif_resize_1991.tif')

#create same extent for both rasters
raster1_extent <- crop(extend(raster1, raster2), raster2)
raster_stacked <- stack(raster1_extent, raster2)
#names(raster_stacked) <- c("ppt_pearson_output_1991", "ppt_bil2tif_resize_1991")

plot(raster_stacked)

x <- raster1
y <- raster2_extent

#corr <- raster.modifed.ttest(raster1_extent, raster2) 

r.cor <- rasterCorrelation(raster1_extent, raster2, s = 11, type = "pearson")
plot(r.cor)




