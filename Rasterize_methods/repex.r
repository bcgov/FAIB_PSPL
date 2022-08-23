

# create small raster
m <- matrix(1:4,nrow=2,ncol=2)
rm <- terra::rast(m)


rm[1] <- 178400063
rm[2] <- 178400064
rm[3] <- 178400065
rm[4] <- 178400066

terra::writeRaster(rm, file="test_i.tif", overwrite=TRUE, datatype = 'INT4U')
terra::writeRaster(rm, file="test_f.tif", overwrite=TRUE, datatype = 'FLT4S')

ri <- terra::rast("test_i.tif")
rf <- terra::rast("test_f.tif")

# integer values
terra::values(ri)

# float(values)
terra::values(rf)




