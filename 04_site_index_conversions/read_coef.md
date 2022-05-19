Table of site idnex conversion coefficients.  
Taken from Sindex by Ken Pollson

s1 = species that has a missing site index value  
s2 = acceptable species site index that can be used to convert from  
b0 = intercept  
b1 = slope  
flag = extra conversion field

    library(kableExtra)

    fname <- paste0(substr(getwd(),1,1),':/Data/GitManagedProjects/FAIB_PSPL/04_site_index_conversions/conversion_equations.txt')

    coeff <- data.table::fread(fname,sep=',')


    kable(coeff,format="markdown",caption = 'Species Site Index Conversion Coefficients') %>%
    kable_styling(bootstrap_options = c("striped"),full_width=F,font_size=13,position = 'left')

    ## Warning in kable_styling(., bootstrap_options = c("striped"), full_width = F, :
    ## Please specify format in kable. kableExtra can customize either HTML or LaTeX
    ## outputs. See https://haozhu233.github.io/kableExtra/ for details.

<table>
<caption>Species Site Index Conversion Coefficients</caption>
<thead>
<tr class="header">
<th style="text-align: left;">s1</th>
<th style="text-align: left;">s2</th>
<th style="text-align: right;">b0</th>
<th style="text-align: right;">b1</th>
<th style="text-align: left;">flag</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">at</td>
<td style="text-align: left;">sw</td>
<td style="text-align: right;">-4.7681123</td>
<td style="text-align: right;">1.2534470</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">at</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">-4.7681123</td>
<td style="text-align: right;">1.2534470</td>
<td style="text-align: left;">SW</td>
</tr>
<tr class="odd">
<td style="text-align: left;">at</td>
<td style="text-align: left;">se</td>
<td style="text-align: right;">-4.7681123</td>
<td style="text-align: right;">1.2534470</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">at</td>
<td style="text-align: left;">bl</td>
<td style="text-align: right;">-7.2167064</td>
<td style="text-align: right;">1.4574965</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">at</td>
<td style="text-align: left;">pl</td>
<td style="text-align: right;">-7.4521238</td>
<td style="text-align: right;">1.3624424</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">at</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-12.8466376</td>
<td style="text-align: right;">1.7007422</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="odd">
<td style="text-align: left;">ba</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">-1.9773176</td>
<td style="text-align: right;">0.9861933</td>
<td style="text-align: left;">C</td>
</tr>
<tr class="even">
<td style="text-align: left;">ba</td>
<td style="text-align: left;">ss</td>
<td style="text-align: right;">1.9280079</td>
<td style="text-align: right;">0.7899408</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">ba</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">1.9280079</td>
<td style="text-align: right;">0.7899408</td>
<td style="text-align: left;">SS</td>
</tr>
<tr class="even">
<td style="text-align: left;">ba</td>
<td style="text-align: left;">cw</td>
<td style="text-align: right;">-0.7386588</td>
<td style="text-align: right;">1.0335306</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">ba</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-2.4033531</td>
<td style="text-align: right;">0.8865878</td>
<td style="text-align: left;">C</td>
</tr>
<tr class="even">
<td style="text-align: left;">bl</td>
<td style="text-align: left;">sw</td>
<td style="text-align: right;">1.6800000</td>
<td style="text-align: right;">0.8600000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">bl</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">1.6800000</td>
<td style="text-align: right;">0.8600000</td>
<td style="text-align: left;">SW</td>
</tr>
<tr class="even">
<td style="text-align: left;">bl</td>
<td style="text-align: left;">pl</td>
<td style="text-align: right;">0.4743119</td>
<td style="text-align: right;">0.9174312</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">bl</td>
<td style="text-align: left;">at</td>
<td style="text-align: right;">4.9514400</td>
<td style="text-align: right;">0.6861080</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">bl</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-0.2211009</td>
<td style="text-align: right;">0.9816514</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="odd">
<td style="text-align: left;">bl</td>
<td style="text-align: left;">lw</td>
<td style="text-align: right;">-1.3605505</td>
<td style="text-align: right;">0.9541284</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">bl</td>
<td style="text-align: left;">sb</td>
<td style="text-align: right;">-3.4972477</td>
<td style="text-align: right;">1.4366972</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">cw</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">-1.1984733</td>
<td style="text-align: right;">0.9541985</td>
<td style="text-align: left;">C</td>
</tr>
<tr class="even">
<td style="text-align: left;">cw</td>
<td style="text-align: left;">ba</td>
<td style="text-align: right;">0.7146947</td>
<td style="text-align: right;">0.9675572</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">cw</td>
<td style="text-align: left;">ss</td>
<td style="text-align: right;">2.5801527</td>
<td style="text-align: right;">0.7643130</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">cw</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">2.5801527</td>
<td style="text-align: right;">0.7643130</td>
<td style="text-align: left;">SS</td>
</tr>
<tr class="odd">
<td style="text-align: left;">cw</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-1.6106870</td>
<td style="text-align: right;">0.8578244</td>
<td style="text-align: left;">C</td>
</tr>
<tr class="even">
<td style="text-align: left;">fdc</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">0.4805339</td>
<td style="text-align: right;">1.1123470</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">fdc</td>
<td style="text-align: left;">cw</td>
<td style="text-align: right;">1.8776418</td>
<td style="text-align: right;">1.1657397</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">fdc</td>
<td style="text-align: left;">ba</td>
<td style="text-align: right;">2.7107898</td>
<td style="text-align: right;">1.1279199</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">fdc</td>
<td style="text-align: left;">ss</td>
<td style="text-align: right;">4.8854282</td>
<td style="text-align: right;">0.8909900</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">fdc</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">4.8854282</td>
<td style="text-align: right;">0.8909900</td>
<td style="text-align: left;">SS</td>
</tr>
<tr class="odd">
<td style="text-align: left;">fdi</td>
<td style="text-align: left;">pl</td>
<td style="text-align: right;">0.7084112</td>
<td style="text-align: right;">0.9345794</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">fdi</td>
<td style="text-align: left;">bl</td>
<td style="text-align: right;">0.2252336</td>
<td style="text-align: right;">1.0186916</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">fdi</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">4.5600000</td>
<td style="text-align: right;">0.8870000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">fdi</td>
<td style="text-align: left;">sw</td>
<td style="text-align: right;">4.7500000</td>
<td style="text-align: right;">0.7370000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">fdi</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">4.7500000</td>
<td style="text-align: right;">0.7370000</td>
<td style="text-align: left;">SW</td>
</tr>
<tr class="even">
<td style="text-align: left;">fdi</td>
<td style="text-align: left;">at</td>
<td style="text-align: right;">7.5535480</td>
<td style="text-align: right;">0.5879786</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">fdi</td>
<td style="text-align: left;">lw</td>
<td style="text-align: right;">-0.6900000</td>
<td style="text-align: right;">0.9830000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">fdi</td>
<td style="text-align: left;">sb</td>
<td style="text-align: right;">-3.3373832</td>
<td style="text-align: right;">1.4635514</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">hwc</td>
<td style="text-align: left;">cw</td>
<td style="text-align: right;">1.2560000</td>
<td style="text-align: right;">1.0480000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">hwc</td>
<td style="text-align: left;">ba</td>
<td style="text-align: right;">2.0050000</td>
<td style="text-align: right;">1.0140000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">hwc</td>
<td style="text-align: left;">ss</td>
<td style="text-align: right;">3.9600000</td>
<td style="text-align: right;">0.8010000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">hwc</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">3.9600000</td>
<td style="text-align: right;">0.8010000</td>
<td style="text-align: left;">SS</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hwc</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-0.4320000</td>
<td style="text-align: right;">0.8990000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">hwi</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-5.1409245</td>
<td style="text-align: right;">1.1273957</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">hwi</td>
<td style="text-align: left;">sw</td>
<td style="text-align: right;">0.2142052</td>
<td style="text-align: right;">0.8308906</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">hwi</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">0.2142052</td>
<td style="text-align: right;">0.8308906</td>
<td style="text-align: left;">SW</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hwi</td>
<td style="text-align: left;">pl</td>
<td style="text-align: right;">-4.3422647</td>
<td style="text-align: right;">1.0536409</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">hwi</td>
<td style="text-align: left;">lw</td>
<td style="text-align: right;">-5.9188275</td>
<td style="text-align: right;">1.1082300</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">lw</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">0.7019329</td>
<td style="text-align: right;">1.0172940</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="even">
<td style="text-align: left;">lw</td>
<td style="text-align: left;">bl</td>
<td style="text-align: right;">1.4259615</td>
<td style="text-align: right;">1.0480769</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">lw</td>
<td style="text-align: left;">pl</td>
<td style="text-align: right;">1.9230769</td>
<td style="text-align: right;">0.9615385</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">lw</td>
<td style="text-align: left;">sw</td>
<td style="text-align: right;">3.8173077</td>
<td style="text-align: right;">0.8846154</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">lw</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">3.8173077</td>
<td style="text-align: right;">0.8846154</td>
<td style="text-align: left;">SW</td>
</tr>
<tr class="even">
<td style="text-align: left;">lw</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">5.3407935</td>
<td style="text-align: right;">0.9023398</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="odd">
<td style="text-align: left;">lw</td>
<td style="text-align: left;">sb</td>
<td style="text-align: right;">-2.2394231</td>
<td style="text-align: right;">1.5057692</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">pl</td>
<td style="text-align: left;">sw</td>
<td style="text-align: right;">1.9700000</td>
<td style="text-align: right;">0.9200000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">pl</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">1.9700000</td>
<td style="text-align: right;">0.9200000</td>
<td style="text-align: left;">SW</td>
</tr>
<tr class="even">
<td style="text-align: left;">pl</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">4.1212000</td>
<td style="text-align: right;">0.9490900</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="odd">
<td style="text-align: left;">pl</td>
<td style="text-align: left;">at</td>
<td style="text-align: right;">5.4696800</td>
<td style="text-align: right;">0.7339760</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">pl</td>
<td style="text-align: left;">bl</td>
<td style="text-align: right;">-0.5170000</td>
<td style="text-align: right;">1.0900000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">pl</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-0.7580000</td>
<td style="text-align: right;">1.0700000</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="even">
<td style="text-align: left;">pl</td>
<td style="text-align: left;">lw</td>
<td style="text-align: right;">-2.0000000</td>
<td style="text-align: right;">1.0400000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">pl</td>
<td style="text-align: left;">sb</td>
<td style="text-align: right;">-4.3290000</td>
<td style="text-align: right;">1.5660000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sb</td>
<td style="text-align: left;">pl</td>
<td style="text-align: right;">2.7643678</td>
<td style="text-align: right;">0.6385696</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">sb</td>
<td style="text-align: left;">lw</td>
<td style="text-align: right;">1.4872286</td>
<td style="text-align: right;">0.6641124</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sb</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">2.2803321</td>
<td style="text-align: right;">0.6832695</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sb</td>
<td style="text-align: left;">bl</td>
<td style="text-align: right;">2.4342273</td>
<td style="text-align: right;">0.6960409</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sb</td>
<td style="text-align: left;">sw</td>
<td style="text-align: right;">4.0223499</td>
<td style="text-align: right;">0.5874840</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">sb</td>
<td style="text-align: left;">sx</td>
<td style="text-align: right;">4.0223499</td>
<td style="text-align: right;">0.5874840</td>
<td style="text-align: left;">SW</td>
</tr>
<tr class="even">
<td style="text-align: left;">ss</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">-4.9438202</td>
<td style="text-align: right;">1.2484394</td>
<td style="text-align: left;">C</td>
</tr>
<tr class="odd">
<td style="text-align: left;">ss</td>
<td style="text-align: left;">ba</td>
<td style="text-align: right;">-2.4406991</td>
<td style="text-align: right;">1.2659176</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">ss</td>
<td style="text-align: left;">cw</td>
<td style="text-align: right;">-3.3757803</td>
<td style="text-align: right;">1.3083645</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">ss</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-5.4831461</td>
<td style="text-align: right;">1.1223471</td>
<td style="text-align: left;">C</td>
</tr>
<tr class="even">
<td style="text-align: left;">sw</td>
<td style="text-align: left;">pl</td>
<td style="text-align: right;">-2.1413044</td>
<td style="text-align: right;">1.0869565</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">sw</td>
<td style="text-align: left;">at</td>
<td style="text-align: right;">3.8040000</td>
<td style="text-align: right;">0.7978000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sw</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">-0.2578019</td>
<td style="text-align: right;">1.2035278</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sw</td>
<td style="text-align: left;">bl</td>
<td style="text-align: right;">-1.9534884</td>
<td style="text-align: right;">1.1627907</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sw</td>
<td style="text-align: left;">lw</td>
<td style="text-align: right;">-4.3152174</td>
<td style="text-align: right;">1.1304348</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">sw</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-6.4450475</td>
<td style="text-align: right;">1.3568521</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="even">
<td style="text-align: left;">sw</td>
<td style="text-align: left;">sb</td>
<td style="text-align: right;">-6.8467391</td>
<td style="text-align: right;">1.7021739</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">-4.9438202</td>
<td style="text-align: right;">1.2484394</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">ba</td>
<td style="text-align: right;">-2.4406991</td>
<td style="text-align: right;">1.2659176</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">cw</td>
<td style="text-align: right;">-3.3757803</td>
<td style="text-align: right;">1.3083645</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-5.4831461</td>
<td style="text-align: right;">1.1223471</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">pl</td>
<td style="text-align: right;">-2.1413044</td>
<td style="text-align: right;">1.0869565</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">at</td>
<td style="text-align: right;">3.8040000</td>
<td style="text-align: right;">0.7978000</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">hw</td>
<td style="text-align: right;">-0.2578019</td>
<td style="text-align: right;">1.2035278</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="even">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">bl</td>
<td style="text-align: right;">-1.9534884</td>
<td style="text-align: right;">1.1627907</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">lw</td>
<td style="text-align: right;">-4.3152174</td>
<td style="text-align: right;">1.1304348</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">fd</td>
<td style="text-align: right;">-6.4450475</td>
<td style="text-align: right;">1.3568521</td>
<td style="text-align: left;">I</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sx</td>
<td style="text-align: left;">sb</td>
<td style="text-align: right;">-6.8467391</td>
<td style="text-align: right;">1.7021739</td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

Species Site Index Conversion Coefficients

Table 1. Conversion Coefficients.

Note that a flag is used under certain conditions.  
This follows the C code implimetation.

In general C/I indicates coast interior and is used for Cedare, Hemlock
and Douglas Fir.

SS, SW are used to indicate coast / interior and differentiate between
Sitka spruce, Englemann spruce and White spruce when refernencing Sx as
a hybrid.

    # add attribution to match how C handled things  
    # coast interior indicator
      
      dt$c_i <- case_when(
        dt$bec_zone == 'CWH' ~ 'C',
        dt$bec_zone == 'CDF' ~ 'C',
        dt$bec_zone == 'MH' ~ 'C',
        TRUE ~ 'I'
      )
      
    # Original code uses indicator for Spruce depending on BEC
      
      dt$se_ss_sw <- case_when(
        dt$c_i == 'C' ~ 'SS',
        dt$c_i == 'I' & dt$bec_zone == 'ESSF' ~ 'SE',
        TRUE ~ 'SW'
      )
