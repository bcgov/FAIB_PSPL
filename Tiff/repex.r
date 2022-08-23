# example of int vs float storage for large(ish) numbers 

# create small raster
m <- matrix(1:4,nrow=2,ncol=2)
rm <- terra::rast(m)

# populate with integer values
r[1] <- 178400063
r[2] <- 178400064
r[3] <- 178400065
r[4] <- 178400066

# check that values are what we expect
terra::values(r)


# note on data type 
# INT4U is available but they are best avoided as R does not support 32-bit unsigned integers.

# write as integer INT4S
terra::writeRaster(r, file="test_i.tif", overwrite=TRUE, datatype = 'INT4S')

# write as float FLT4S
terra::writeRaster(rm, file="test_f4.tif", overwrite=TRUE, datatype = 'FLT4S')

# write as float FLT8S
terra::writeRaster(rm, file="test_f8.tif", overwrite=TRUE, datatype = 'FLT8S')

# read Tifs
ri  <- terra::rast("test_i.tif")
rf4 <- terra::rast("test_f4.tif")
rf8 <- terra::rast("test_f8.tif")

# integer values
terra::values(ri)

# float(values) FLT4S
terra::values(rf4)

# float(values) FLT8S
terra::values(rf8)

# according to documentation
# FLT4S	-3.4e+38	3.4e+38
# FLT8S	-1.7e+308	1.7e+308




