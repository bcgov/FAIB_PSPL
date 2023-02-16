# PSPL Method 2022

## Version testing V1

2023.feb.16

Version 3.1

Process Order:

-   load features with species from MSYT process
-   Sx conversion
-   First conversion SIndex coefficients
-   BEC bases substitutions

## feature\_id processing

Requires the following tables:

-   site\_index\_mean\_fid
-   site\_index\_mean\_bec

Start: Thu Feb 16 08:37:09 2023

## Load mean value site inde data from PSPL

Thu Feb 16 08:37:13 2023

<table>
<thead>
<tr class="header">
<th style="text-align: left;">src</th>
<th style="text-align: right;">n</th>
<th style="text-align: left;">pct</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">PSPL</td>
<td style="text-align: right;">1382340</td>
<td style="text-align: left;">27</td>
</tr>
<tr class="even">
<td style="text-align: left;">Total</td>
<td style="text-align: right;">5061415</td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

Table 1. Base PSPL Missing Site Index values

Initially, the raw PSPL has site index values for all required species
for 27%.

# Spruce conversions

Change SX to Sw, Se Ss based on BEC.

<table>
<thead>
<tr class="header">
<th style="text-align: left;">src</th>
<th style="text-align: right;">n</th>
<th style="text-align: left;">pct</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">PSPL</td>
<td style="text-align: right;">1382340</td>
<td style="text-align: left;">27</td>
</tr>
<tr class="even">
<td style="text-align: left;">Spruce Conversion</td>
<td style="text-align: right;">668018</td>
<td style="text-align: left;">13</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Total</td>
<td style="text-align: right;">5061415</td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

Table 2. After SX substitutions

After substituting for Sx, the valid site index percentage has increased
to 40%.

# Base conversion

Using SIndex coefficients

<table>
<thead>
<tr class="header">
<th style="text-align: left;">src</th>
<th style="text-align: right;">n</th>
<th style="text-align: left;">pct</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">PSPL</td>
<td style="text-align: right;">1382340</td>
<td style="text-align: left;">27</td>
</tr>
<tr class="even">
<td style="text-align: left;">Spruce Conversion</td>
<td style="text-align: right;">668018</td>
<td style="text-align: left;">13</td>
</tr>
<tr class="odd">
<td style="text-align: left;">SIndex Conversion(1)</td>
<td style="text-align: right;">2885987</td>
<td style="text-align: left;">57</td>
</tr>
<tr class="even">
<td style="text-align: left;">Total</td>
<td style="text-align: right;">5061415</td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

Table 3. After SIndex conversions where a species is mising a site
index.

The valid site index percentage has increased to 97%.

# BEC site index substitutions

Based on mean BEC site index values from PSPL

<table>
<thead>
<tr class="header">
<th style="text-align: left;">src</th>
<th style="text-align: right;">n</th>
<th style="text-align: left;">pct</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">PSPL</td>
<td style="text-align: right;">1382340</td>
<td style="text-align: left;">27</td>
</tr>
<tr class="even">
<td style="text-align: left;">Spruce Conversion</td>
<td style="text-align: right;">668018</td>
<td style="text-align: left;">13</td>
</tr>
<tr class="odd">
<td style="text-align: left;">SIndex Conversion(1)</td>
<td style="text-align: right;">2885987</td>
<td style="text-align: left;">57</td>
</tr>
<tr class="even">
<td style="text-align: left;">BEC Conversion</td>
<td style="text-align: right;">114563</td>
<td style="text-align: left;">2</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Total</td>
<td style="text-align: right;">5061415</td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

Table 4. After BEC substitutions.

The valid site index percentage has increased to 99%.

## Still missing

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

Table 5. Missing Species site index values after BEC substitutions

The major missing species after this substitution is Pw.

## Final Conversion

Run SIndex conversion a second time.

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

Table 6. After running base SIndex conversions a second time

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
<td style="text-align: left;">PSPL</td>
<td style="text-align: right;">1382340</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">27.3</td>
</tr>
<tr class="even">
<td style="text-align: left;">Spruce Conversion</td>
<td style="text-align: right;">668018</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">13.2</td>
</tr>
<tr class="odd">
<td style="text-align: left;">SIndex Conversion(1)</td>
<td style="text-align: right;">2885987</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">57.0</td>
</tr>
<tr class="even">
<td style="text-align: left;">BEC Conversion</td>
<td style="text-align: right;">114563</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">2.3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">SIndex Conversion(2)</td>
<td style="text-align: right;">10507</td>
<td style="text-align: right;">5</td>
<td style="text-align: right;">0.2</td>
</tr>
</tbody>
</table>

Table 7. Final results

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
<td style="text-align: left;">PSPL</td>
<td style="text-align: left;">original data from PSPL that has all
requires species site index values</td>
</tr>
<tr class="even">
<td style="text-align: left;">Spruce Conversion</td>
<td style="text-align: left;">Spruce conversions from SX to Sw, Se,
Ss</td>
</tr>
<tr class="odd">
<td style="text-align: left;">SIndex Conversion(1)</td>
<td style="text-align: left;">SIndex site index conversions</td>
</tr>
<tr class="even">
<td style="text-align: left;">BEC Conversion</td>
<td style="text-align: left;">Site index from BEC mean values</td>
</tr>
<tr class="odd">
<td style="text-align: left;">SIndex Conversion(2)</td>
<td style="text-align: left;">SIndex conversions run a second time</td>
</tr>
</tbody>
</table>

End: Thu Feb 16 08:42:49 2023
