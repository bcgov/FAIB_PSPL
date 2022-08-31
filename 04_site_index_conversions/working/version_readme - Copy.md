# Versions of site index conversion 

## v0

- Direct translation of C code to R
- used cascade type if then else
- augmented site onverions for those not in the original C code

## v1

- transform form if then else to case_when
- cleaner code
- yield exactly the same result over 4.7M rows when comapred to v0

## v2

- applied spruce site index conversion as first step
	- Sw_si = Sx_si where Sw_si = 0 and Sx_si > 0
- this only impacts Sw
	