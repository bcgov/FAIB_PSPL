## 2 Different Intersection Methods

Terra raster intersection vs PosgreSQl st\_contains vector intersection

Note that Terra method has some issues:

-   handling of NULLs in GDB is inconsistent (0 and NaN are used)

-   process takes almost 32GB to complete

-   while faster, it might be best to use the st\_contains8

## row count from source

    ## [1] TRUE

<table>
<thead>
<tr class="header">
<th style="text-align: right;">Unit</th>
<th style="text-align: right;">st_contains n</th>
<th style="text-align: right;">terra n</th>
<th style="text-align: right;">Diff</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: right;">1160754</td>
<td style="text-align: right;">1160754</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">2</td>
<td style="text-align: right;">1116479</td>
<td style="text-align: right;">1116480</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: right;">1288985</td>
<td style="text-align: right;">1288985</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">4</td>
<td style="text-align: right;">620797</td>
<td style="text-align: right;">620797</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">5</td>
<td style="text-align: right;">659512</td>
<td style="text-align: right;">659512</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">6</td>
<td style="text-align: right;">199285</td>
<td style="text-align: right;">199285</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: right;">3698715</td>
<td style="text-align: right;">3698716</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="even">
<td style="text-align: right;">8</td>
<td style="text-align: right;">1111498</td>
<td style="text-align: right;">1111499</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="odd">
<td style="text-align: right;">9</td>
<td style="text-align: right;">2781833</td>
<td style="text-align: right;">2781834</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="even">
<td style="text-align: right;">10</td>
<td style="text-align: right;">6797838</td>
<td style="text-align: right;">6797838</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">11</td>
<td style="text-align: right;">4083303</td>
<td style="text-align: right;">4083303</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">12</td>
<td style="text-align: right;">906451</td>
<td style="text-align: right;">906451</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">13</td>
<td style="text-align: right;">719288</td>
<td style="text-align: right;">719288</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: right;">3142988</td>
<td style="text-align: right;">3142989</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="odd">
<td style="text-align: right;">15</td>
<td style="text-align: right;">781318</td>
<td style="text-align: right;">781318</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">16</td>
<td style="text-align: right;">949453</td>
<td style="text-align: right;">949453</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">17</td>
<td style="text-align: right;">790370</td>
<td style="text-align: right;">790370</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">18</td>
<td style="text-align: right;">410945</td>
<td style="text-align: right;">410945</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">19</td>
<td style="text-align: right;">2289122</td>
<td style="text-align: right;">2289122</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">20</td>
<td style="text-align: right;">912794</td>
<td style="text-align: right;">912794</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: right;">935854</td>
<td style="text-align: right;">935854</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">22</td>
<td style="text-align: right;">1346762</td>
<td style="text-align: right;">1346762</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">23</td>
<td style="text-align: right;">719550</td>
<td style="text-align: right;">719550</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">24</td>
<td style="text-align: right;">3233514</td>
<td style="text-align: right;">3233514</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">25</td>
<td style="text-align: right;">1067345</td>
<td style="text-align: right;">1067346</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="even">
<td style="text-align: right;">26</td>
<td style="text-align: right;">1235066</td>
<td style="text-align: right;">1235066</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">27</td>
<td style="text-align: right;">638000</td>
<td style="text-align: right;">638000</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">28</td>
<td style="text-align: right;">1265909</td>
<td style="text-align: right;">1265909</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">29</td>
<td style="text-align: right;">2153611</td>
<td style="text-align: right;">2153611</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">30</td>
<td style="text-align: right;">376936</td>
<td style="text-align: right;">376936</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">31</td>
<td style="text-align: right;">7043866</td>
<td style="text-align: right;">7043866</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">32</td>
<td style="text-align: right;">1951201</td>
<td style="text-align: right;">1951201</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">33</td>
<td style="text-align: right;">470103</td>
<td style="text-align: right;">470103</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">34</td>
<td style="text-align: right;">717652</td>
<td style="text-align: right;">717652</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">35</td>
<td style="text-align: right;">439837</td>
<td style="text-align: right;">439837</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="even">
<td style="text-align: right;">36</td>
<td style="text-align: right;">699062</td>
<td style="text-align: right;">699062</td>
<td style="text-align: right;">0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">37</td>
<td style="text-align: right;">4048763</td>
<td style="text-align: right;">4048763</td>
<td style="text-align: right;">0</td>
</tr>
</tbody>
</table>

Table 1. Intersection Method compare

Note that there are 6 more intersected points in the Terra method.

This is due to raster vs vector processing.

Example:

![](point_outside.PNG)
