Here is an example of how R handles the storage of large(ish) values in
a Tif file.

In the case of the VRI we are interested in storing the feature\_id.

The max value is: 19,258,969

## Simple Example

Create a 4x4 raster and fill with values ranging from 17840063 to
17840066.

These values were chosen as they were seen to be causing problems.

<table>
<thead>
<tr>
<th style="text-align:right;">
Original Value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
17840063
</td>
</tr>
<tr>
<td style="text-align:right;">
17840064
</td>
</tr>
<tr>
<td style="text-align:right;">
17840065
</td>
</tr>
<tr>
<td style="text-align:right;">
17840066
</td>
</tr>
</tbody>
</table>

## Write to Tif using specified datatype

Create 3 Tifs using the following datatypes:

-   INT4S
-   FLT4S
-   FLT8S

Note that the terra::writeRaster data types are listed as:

-   INT1U
-   INT2U (short)
-   INT2S (short)
-   INT4U (long)
-   INT4S (long)
-   FLT4S (single precision float)
-   FLT8S (double precision float)

Where the 4th character indicates the number of bytes used.

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Data type</th>
<th style="text-align: left;">Minimum value</th>
<th style="text-align: left;">Maximum value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">INT1U</td>
<td style="text-align: left;">0</td>
<td style="text-align: left;">255</td>
</tr>
<tr class="even">
<td style="text-align: left;">INT2S</td>
<td style="text-align: left;">-32,767</td>
<td style="text-align: left;">32,767</td>
</tr>
<tr class="odd">
<td style="text-align: left;">INT2U</td>
<td style="text-align: left;">0</td>
<td style="text-align: left;">65,534</td>
</tr>
<tr class="even">
<td style="text-align: left;">INT4S</td>
<td style="text-align: left;">-2,147,483,647</td>
<td style="text-align: left;">2,147,483,647</td>
</tr>
<tr class="odd">
<td style="text-align: left;">INT4U</td>
<td style="text-align: left;">0</td>
<td style="text-align: left;">4,294,967,296</td>
</tr>
<tr class="even">
<td style="text-align: left;">FLT4S</td>
<td style="text-align: left;">-3.4e+38</td>
<td style="text-align: left;">3.4e+38</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FLT8S</td>
<td style="text-align: left;">-1.7e+308</td>
<td style="text-align: left;">1.7e+308</td>
</tr>
</tbody>
</table>

Now look at what was written in the Tifs.

------------------------------------------------------------------------

## Integer INT4S

Note that we are using INT4S as INT4U is not supported in R.

Read the Tif and display values:

<table>
<thead>
<tr>
<th style="text-align:right;">
Value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
17840063
</td>
</tr>
<tr>
<td style="text-align:right;">
17840064
</td>
</tr>
<tr>
<td style="text-align:right;">
17840065
</td>
</tr>
<tr>
<td style="text-align:right;">
17840066
</td>
</tr>
</tbody>
</table>

Here the values are exacly as expected.

------------------------------------------------------------------------

## Single Precision Floating Point: FLT4S

Read the Tif and display the values:

<table>
<thead>
<tr>
<th style="text-align:right;">
Value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
17840064
</td>
</tr>
<tr>
<td style="text-align:right;">
17840064
</td>
</tr>
<tr>
<td style="text-align:right;">
17840064
</td>
</tr>
<tr>
<td style="text-align:right;">
17840066
</td>
</tr>
</tbody>
</table>

Here the values are being rounded due to floating point representation.

According to the documentation:

FLT4S -3.4e+38 3.4e+38

So, in theory we should be able to store a single precision value
without rounding.

------------------------------------------------------------------------

## Double Precision Floating Point: FLT8S

Read the Tif and display the values:

<table>
<thead>
<tr>
<th style="text-align:right;">
Value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
17840063
</td>
</tr>
<tr>
<td style="text-align:right;">
17840064
</td>
</tr>
<tr>
<td style="text-align:right;">
17840065
</td>
</tr>
<tr>
<td style="text-align:right;">
17840066
</td>
</tr>
</tbody>
</table>

Here we see that the values are the same as the original integer values.

------------------------------------------------------------------------

## Discussion

Computers store decimal values in 3 pieces:

-   the sign (+/-)
-   the exponent (biased exponent)
-   the fraction (mantissa)

But the number is stored in binary (base 2).

So in general, we talk about precision:

<table>
<thead>
<tr>
<th style="text-align:left;">
Level
</th>
<th style="text-align:left;">
Precision
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Single Precision
</td>
<td style="text-align:left;">
Approximately 7 decimal digits
</td>
</tr>
<tr>
<td style="text-align:left;">
Double Precision
</td>
<td style="text-align:left;">
Approximately 16 decimal digits
</td>
</tr>
</tbody>
</table>

So if you look up precision it is often specified as a range.

The number that we are trying to represent is 17,840,063

This is represented in scientific notation as: 1.7840e+07

So the 3 at the end is going to cause problems for single precision.
This depends on how it tranlates to binary. You may or may not lose some
digits.

<table>
<thead>
<tr>
<th style="text-align:right;">
Decimal
</th>
<th style="text-align:left;">
Binary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
17840063
</td>
<td style="text-align:left;">
1000100000011011110111111
</td>
</tr>
<tr>
<td style="text-align:right;">
17840064
</td>
<td style="text-align:left;">
1000100000011011111000000
</td>
</tr>
<tr>
<td style="text-align:right;">
17840065
</td>
<td style="text-align:left;">
1000100000011011111000001
</td>
</tr>
<tr>
<td style="text-align:right;">
17840066
</td>
<td style="text-align:left;">
1000100000011011111000010
</td>
</tr>
</tbody>
</table>

So 17840063 and 17840065 are loosing precision due to digit rounding and
thus are turning into 17840064 and 17840066.

The largest number that can be stored in single precision is actually
16,777,216 so we are well beyond that range.

------------------------------------------------------------------------

## Oracle Table

The base data (feature\_id) comes from an Oracle Spatial table:
whse\_forest\_vegetation.veg\_comp\_lyr\_r1\_poly

The data type for this column is: NUMBER(38)

Which is defined as:

-   variable length numeric data
-   38 = number of digits in the number
-   creates a column intended for integers

So in the LRDW, the feature\_id is stored as a Long Integer.

------------------------------------------------------------------------

## ESRI Land

If ARCMap is used to look at the data type of feature\_id in
whse\_forest\_vegetation.veg\_comp\_lyr\_r1\_poly it is typed as: LONG

------------------------------------------------------------------------

## GDAL Data Types

In the GDAL documentation, the list of supported integer data types
includes:

-   Int16 (short)
-   Int32 (long)

Since the max value for Int32 is 2,147,483,647 this should be adequate
to allow for future feature\_ids.

------------------------------------------------------------------------

## Recommendations

To avoid having these types of rounding, it is best to use either Long
Integer (INT4S) or Double Precision floating (FLT8S).

These **MUST** be specified on the write to raster call.

Note that if no datatype is specified on the write, ‘FLT4S’ is used.
This will cause problems with large numbers.

It would be my recommendation that we use Long Integer.

------------------------------------------------------------------------

Reference:

<https://blog.demofox.org/2017/11/21/floating-point-precision/>
