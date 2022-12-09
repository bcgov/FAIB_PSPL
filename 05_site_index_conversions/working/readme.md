# PSPL Site Index Conversion

After the mean site index values have been assigned, then can be species that have missing site index values.  This will be discussed on more formal documentation.  But for processing requirements we need to fill in missing values where possible using a formalized set of site index conversions.  

## Conversion Equations




## Versions of site index conversion 

### v0

- Direct translation of C code to R
- used cascade type if then else
- augmented site conversions for those not in the original C code

### v1

- transform form if then else to case_when
- cleaner code
- yield exactly the same result over 4.7M rows when comapred to v0

### v2

- applied spruce site index conversion as first step
	- Sw_si = Sx_si where Sw_si = 0 and Sx_si > 0
- this only impacts Sw
	