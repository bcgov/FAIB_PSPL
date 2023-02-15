# PSPL Method 2022

## Version testing V1

2023.feb.15

Version 3.1

Fixes:

-   do spruce sx as separate function
-   split the missing and not missing from fid convert

## feature\_id processing

Requires the following tables:

-   site\_index\_mean\_fid
-   site\_index\_mean\_bec

Start: Wed Feb 15 14:49:47 2023

### run SI conversion

### Site Index Conversions

mean value data

Wed Feb 15 14:49:50 2023

# Spruce conversions

Change SX to Sw, Se Ss based on BEC.

# Base conversion

Using SIndex coefficients

# BEC site index substitutions

Based on mean BEC site index values from PSPL

<table>
<thead>
<tr class="header">
<th style="text-align: left;">missing</th>
<th style="text-align: right;">n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">:Pw</td>
<td style="text-align: right;">10360</td>
</tr>
<tr class="even">
<td style="text-align: left;">:Lw</td>
<td style="text-align: right;">73</td>
</tr>
<tr class="odd">
<td style="text-align: left;">:Lt</td>
<td style="text-align: right;">51</td>
</tr>
<tr class="even">
<td style="text-align: left;">:Ba</td>
<td style="text-align: right;">14</td>
</tr>
<tr class="odd">
<td style="text-align: left;">:Bg</td>
<td style="text-align: right;">8</td>
</tr>
<tr class="even">
<td style="text-align: left;">:Dr</td>
<td style="text-align: right;">1</td>
</tr>
</tbody>
</table>

Table 1. Missing After BEC substitutions

<table>
<thead>
<tr class="header">
<th style="text-align: left;">missing</th>
<th style="text-align: right;">n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: right;">10507</td>
</tr>
</tbody>
</table>

Table 2. After running base SIndex conversions a second time

If missing = BLANK, then we are done.

# summary of Conversion Results

<table>
<thead>
<tr class="header">
<th style="text-align: left;">src</th>
<th style="text-align: right;">n</th>
<th style="text-align: right;">ord</th>
<th style="text-align: right;">pct</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">pspl</td>
<td style="text-align: right;">1382340</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">27.3</td>
</tr>
<tr class="even">
<td style="text-align: left;">spruce_conv</td>
<td style="text-align: right;">668018</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">13.2</td>
</tr>
<tr class="odd">
<td style="text-align: left;">base1</td>
<td style="text-align: right;">2885987</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">57.0</td>
</tr>
<tr class="even">
<td style="text-align: left;">bec_convert</td>
<td style="text-align: right;">114563</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">2.3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">base2</td>
<td style="text-align: right;">10507</td>
<td style="text-align: right;">5</td>
<td style="text-align: right;">0.2</td>
</tr>
</tbody>
</table>

Table 3. Final results

Notes:

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">src</th>
<th style="text-align: left;">description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">pspl</td>
<td style="text-align: left;">original data from PSPL that has all
requires species site index values</td>
</tr>
<tr class="even">
<td style="text-align: left;">spruce_conv</td>
<td style="text-align: left;">Spruce conversions form SX to Sw, Se,
Ss</td>
</tr>
<tr class="odd">
<td style="text-align: left;">base1</td>
<td style="text-align: left;">SIndex site index conversions</td>
</tr>
<tr class="even">
<td style="text-align: left;">bec_convert</td>
<td style="text-align: left;">Site index from BEC mean values</td>
</tr>
<tr class="odd">
<td style="text-align: left;">base2</td>
<td style="text-align: left;">SIndex conversions run a second time</td>
</tr>
</tbody>
</table>

End: Wed Feb 15 14:55:00 2023
