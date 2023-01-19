## Import from GDB to PostgreSQL

Check:

-   original rows in GDB
-   rows loaded to PostgreSQL
	- loaded via sf::gdal_utils.vectortranslate
	- loaded via System call to OGR2OGR (v 3.5.3)
-   rows with at least one valid site index

Start: 2023-01-19 10:21:14

## row count from source

    ## [1] TRUE

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 9%" />
<col style="width: 13%" />
<col style="width: 10%" />
<col style="width: 12%" />
<col style="width: 11%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Unit</th>
<th style="text-align: left;">GDB n</th>
<th style="text-align: left;">gdal_utils n</th>
<th style="text-align: left;">OGR2OGR n</th>
<th style="text-align: left;">GDAL Valid SI n</th>
<th style="text-align: left;">OGR Valid SI n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">Site_Prod_100_Mile_House</td>
<td style="text-align: left;">1181106</td>
<td style="text-align: left;">1181106</td>
<td style="text-align: left;">1181106</td>
<td style="text-align: left;">1160754</td>
<td style="text-align: left;">1160754</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Arrow</td>
<td style="text-align: left;">1158840</td>
<td style="text-align: left;">1158840</td>
<td style="text-align: left;">1158840</td>
<td style="text-align: left;">1116480</td>
<td style="text-align: left;">1116480</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Arrowsmith</td>
<td style="text-align: left;">1397598</td>
<td style="text-align: left;">1397598</td>
<td style="text-align: left;">1397598</td>
<td style="text-align: left;">1288985</td>
<td style="text-align: left;">1288985</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Boundary</td>
<td style="text-align: left;">627848</td>
<td style="text-align: left;">627848</td>
<td style="text-align: left;">627848</td>
<td style="text-align: left;">620797</td>
<td style="text-align: left;">620797</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Bulkley</td>
<td style="text-align: left;">706549</td>
<td style="text-align: left;">706549</td>
<td style="text-align: left;">706549</td>
<td style="text-align: left;">659512</td>
<td style="text-align: left;">659512</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Cascadia</td>
<td style="text-align: left;">235530</td>
<td style="text-align: left;">235530</td>
<td style="text-align: left;">235530</td>
<td style="text-align: left;">199285</td>
<td style="text-align: left;">199285</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Cassiar</td>
<td style="text-align: left;">11584979</td>
<td style="text-align: left;">11584979</td>
<td style="text-align: left;">11584979</td>
<td style="text-align: left;">3698716</td>
<td style="text-align: left;">3698716</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Cranbrook</td>
<td style="text-align: left;">1163296</td>
<td style="text-align: left;">1163296</td>
<td style="text-align: left;">1163296</td>
<td style="text-align: left;">1111499</td>
<td style="text-align: left;">1111499</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Dawson_Creek</td>
<td style="text-align: left;">2886578</td>
<td style="text-align: left;">2886578</td>
<td style="text-align: left;">2886578</td>
<td style="text-align: left;">2781834</td>
<td style="text-align: left;">2781834</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Fort_Nelson</td>
<td style="text-align: left;">8137232</td>
<td style="text-align: left;">8137232</td>
<td style="text-align: left;">8137232</td>
<td style="text-align: left;">6797838</td>
<td style="text-align: left;">6797838</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Fort_St_John</td>
<td style="text-align: left;">4575950</td>
<td style="text-align: left;">4575950</td>
<td style="text-align: left;">4575950</td>
<td style="text-align: left;">4083303</td>
<td style="text-align: left;">4083303</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Fraser</td>
<td style="text-align: left;">1277207</td>
<td style="text-align: left;">1277207</td>
<td style="text-align: left;">1277207</td>
<td style="text-align: left;">906451</td>
<td style="text-align: left;">906451</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Golden</td>
<td style="text-align: left;">897676</td>
<td style="text-align: left;">897676</td>
<td style="text-align: left;">897676</td>
<td style="text-align: left;">719288</td>
<td style="text-align: left;">719288</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Great_Bear_Rainforest_North</td>
<td style="text-align: left;">3915758</td>
<td style="text-align: left;">3915758</td>
<td style="text-align: left;">3915758</td>
<td style="text-align: left;">3142989</td>
<td style="text-align: left;">3142989</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Great_Bear_Rainforest_South</td>
<td style="text-align: left;">974722</td>
<td style="text-align: left;">974722</td>
<td style="text-align: left;">974722</td>
<td style="text-align: left;">781318</td>
<td style="text-align: left;">781318</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Haida_Gwaii</td>
<td style="text-align: left;">1018812</td>
<td style="text-align: left;">1018812</td>
<td style="text-align: left;">1018812</td>
<td style="text-align: left;">949453</td>
<td style="text-align: left;">949453</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Invermere</td>
<td style="text-align: left;">960109</td>
<td style="text-align: left;">960109</td>
<td style="text-align: left;">960109</td>
<td style="text-align: left;">790370</td>
<td style="text-align: left;">790370</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Kalum</td>
<td style="text-align: left;">564902</td>
<td style="text-align: left;">564902</td>
<td style="text-align: left;">564902</td>
<td style="text-align: left;">410945</td>
<td style="text-align: left;">410945</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Kamloops</td>
<td style="text-align: left;">2464966</td>
<td style="text-align: left;">2464966</td>
<td style="text-align: left;">2464966</td>
<td style="text-align: left;">2289122</td>
<td style="text-align: left;">2289122</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Kispiox</td>
<td style="text-align: left;">970338</td>
<td style="text-align: left;">970338</td>
<td style="text-align: left;">970338</td>
<td style="text-align: left;">912794</td>
<td style="text-align: left;">912794</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Kootenay_Lake</td>
<td style="text-align: left;">1066597</td>
<td style="text-align: left;">1066597</td>
<td style="text-align: left;">1066597</td>
<td style="text-align: left;">935854</td>
<td style="text-align: left;">935854</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Lakes</td>
<td style="text-align: left;">1377731</td>
<td style="text-align: left;">1377731</td>
<td style="text-align: left;">1377731</td>
<td style="text-align: left;">1346762</td>
<td style="text-align: left;">1346762</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Lillooet</td>
<td style="text-align: left;">836864</td>
<td style="text-align: left;">836864</td>
<td style="text-align: left;">836864</td>
<td style="text-align: left;">719550</td>
<td style="text-align: left;">719550</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Mackenzie</td>
<td style="text-align: left;">5408180</td>
<td style="text-align: left;">5408180</td>
<td style="text-align: left;">5408180</td>
<td style="text-align: left;">3233514</td>
<td style="text-align: left;">3233514</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Merritt</td>
<td style="text-align: left;">1112873</td>
<td style="text-align: left;">1112873</td>
<td style="text-align: left;">1112873</td>
<td style="text-align: left;">1067346</td>
<td style="text-align: left;">1067346</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Morice</td>
<td style="text-align: left;">1300445</td>
<td style="text-align: left;">1300445</td>
<td style="text-align: left;">1300445</td>
<td style="text-align: left;">1235066</td>
<td style="text-align: left;">1235066</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Nass</td>
<td style="text-align: left;">842986</td>
<td style="text-align: left;">842986</td>
<td style="text-align: left;">842986</td>
<td style="text-align: left;">638000</td>
<td style="text-align: left;">638000</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_North_Island</td>
<td style="text-align: left;">1385525</td>
<td style="text-align: left;">1385525</td>
<td style="text-align: left;">1385525</td>
<td style="text-align: left;">1265909</td>
<td style="text-align: left;">1265909</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Okanagan</td>
<td style="text-align: left;">2281523</td>
<td style="text-align: left;">2281523</td>
<td style="text-align: left;">2281523</td>
<td style="text-align: left;">2153611</td>
<td style="text-align: left;">2153611</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Pacific</td>
<td style="text-align: left;">518560</td>
<td style="text-align: left;">518560</td>
<td style="text-align: left;">518560</td>
<td style="text-align: left;">376936</td>
<td style="text-align: left;">376936</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Prince_George</td>
<td style="text-align: left;">7507664</td>
<td style="text-align: left;">7507664</td>
<td style="text-align: left;">7507664</td>
<td style="text-align: left;">7043866</td>
<td style="text-align: left;">7043866</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Quesnel</td>
<td style="text-align: left;">1964607</td>
<td style="text-align: left;">1964607</td>
<td style="text-align: left;">1964607</td>
<td style="text-align: left;">1951201</td>
<td style="text-align: left;">1951201</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Revelstoke</td>
<td style="text-align: left;">506172</td>
<td style="text-align: left;">506172</td>
<td style="text-align: left;">506172</td>
<td style="text-align: left;">470103</td>
<td style="text-align: left;">470103</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Robson_Valley</td>
<td style="text-align: left;">756254</td>
<td style="text-align: left;">756254</td>
<td style="text-align: left;">756254</td>
<td style="text-align: left;">717652</td>
<td style="text-align: left;">717652</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Soo</td>
<td style="text-align: left;">585414</td>
<td style="text-align: left;">585414</td>
<td style="text-align: left;">585414</td>
<td style="text-align: left;">439837</td>
<td style="text-align: left;">439837</td>
</tr>
<tr class="even">
<td style="text-align: left;">Site_Prod_Sunshine_Coast</td>
<td style="text-align: left;">849903</td>
<td style="text-align: left;">849903</td>
<td style="text-align: left;">849903</td>
<td style="text-align: left;">699062</td>
<td style="text-align: left;">699062</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Site_Prod_Williams_Lake</td>
<td style="text-align: left;">4153662</td>
<td style="text-align: left;">4153662</td>
<td style="text-align: left;">4153662</td>
<td style="text-align: left;">4048763</td>
<td style="text-align: left;">4048763</td>
</tr>
</tbody>
</table>

Table 1. GDB to PostgreSQL compare

End: 2023-01-19 10:22:22
