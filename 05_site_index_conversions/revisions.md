# PSPL Site Index Conversion

## Changes to Site Index Conversion Methods


### v0

- Direct translation of C code to R
- used cascade type if then else
- augmented site conversions for those not in the original C code

### v1

- transform form if then else to case_when
- cleaner code
- yield exactly the same result over 4.7M rows when comapred to v0


### Testing 

### v2a

- applied spruce site index conversion as first step
	- Sw_si = Sx_si where Sw_si = 0 and Sx_si > 0
- this only impacts Sw

### v2b

- applied the one to one conversions first
- applied spruce site index conversion as second step
	- Sw_si = Sx_si where Sw_si = 0 and Sx_si > 0
- this only impacts Sw
	