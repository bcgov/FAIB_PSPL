# PSPL Method 2022

## Version testing V1

2023.feb.10

Version 3.1

Fixes:

-   do spruce sx as separate function
-   split the missing and not missing from fid convert

## feature\_id processing

Requires the following tables:

-   pspl\_site\_index\_mean\_op

Start: Mon Feb 13 11:35:13 2023

### run SI conversion

### Site Index Conversions

mean value data

Mon Feb 13 11:35:17 2023

<table>
<thead>
<tr class="header">
<th style="text-align: left;">src</th>
<th style="text-align: right;">n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">base1</td>
<td style="text-align: right;">2851777</td>
</tr>
<tr class="even">
<td style="text-align: left;">pspl</td>
<td style="text-align: right;">1002983</td>
</tr>
<tr class="odd">
<td style="text-align: left;">spruce_conv</td>
<td style="text-align: right;">627014</td>
</tr>
</tbody>
</table>

Table 1. Initial missing species site index

Mon Feb 13 11:40:17 2023

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
<td style="text-align: right;">10356</td>
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

Table 2. After BEC substitutions

Mon Feb 13 11:40:27 2023

<table>
<thead>
<tr class="header">
<th style="text-align: left;">missing</th>
<th style="text-align: left;">bec_zone</th>
<th style="text-align: left;">bec_subzone</th>
<th style="text-align: right;">n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">CDF</td>
<td style="text-align: left;">mm</td>
<td style="text-align: right;">10330</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">IDF</td>
<td style="text-align: left;">xw</td>
<td style="text-align: right;">63</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">SBS</td>
<td style="text-align: left;">wk</td>
<td style="text-align: right;">21</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">BWBS</td>
<td style="text-align: left;">mw</td>
<td style="text-align: right;">19</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">ESSF</td>
<td style="text-align: left;">xv</td>
<td style="text-align: right;">13</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">BWBS</td>
<td style="text-align: left;">mk</td>
<td style="text-align: right;">12</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">CWH</td>
<td style="text-align: left;">ds</td>
<td style="text-align: right;">7</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">ICH</td>
<td style="text-align: left;">vc</td>
<td style="text-align: right;">7</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">CWH</td>
<td style="text-align: left;">xm</td>
<td style="text-align: right;">6</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">ICH</td>
<td style="text-align: left;">vk</td>
<td style="text-align: right;">4</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">MH</td>
<td style="text-align: left;">mm</td>
<td style="text-align: right;">4</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">SBPS</td>
<td style="text-align: left;">dc</td>
<td style="text-align: right;">4</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">ESSF</td>
<td style="text-align: left;">mww</td>
<td style="text-align: right;">3</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">IDF</td>
<td style="text-align: left;">ww</td>
<td style="text-align: right;">3</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">ESSF</td>
<td style="text-align: left;">mm</td>
<td style="text-align: right;">2</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">IDF</td>
<td style="text-align: left;">mw</td>
<td style="text-align: right;">2</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">CWH</td>
<td style="text-align: left;">mm</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">MS</td>
<td style="text-align: left;">dm</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">SBS</td>
<td style="text-align: left;">dk</td>
<td style="text-align: right;">1</td>
</tr>
</tbody>
</table>

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
<td style="text-align: right;">1002983</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">21.8</td>
</tr>
<tr class="even">
<td style="text-align: left;">spruce_conv</td>
<td style="text-align: right;">627014</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">13.6</td>
</tr>
<tr class="odd">
<td style="text-align: left;">base1</td>
<td style="text-align: right;">2851777</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">61.9</td>
</tr>
<tr class="even">
<td style="text-align: left;">bec_convert</td>
<td style="text-align: right;">113919</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">2.5</td>
</tr>
<tr class="odd">
<td style="text-align: left;">base2</td>
<td style="text-align: right;">10503</td>
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

    z <- dbDisconnect(con)

End: Mon Feb 13 11:40:36 2023
