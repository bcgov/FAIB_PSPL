## Draft Documentation for editing

2022.05.10  
d waddell

## Overview

The Provincial Site Productivity Layer (PSPL) is used to provide the
site index by species for preparation of the provincial managed stand
yield tables (MSYTs).

The processing of PSPL has changed for 2021. The revised process
reflects how an input to Batch TIPSY would handle site index conversion
to provide site index for species that are missing a site index.

Note that the PSPL data was prepared by Jeff Kruys (under contract).  
Version 8, released oct 2021

### Gaps

PSPL site indices are assigned in a hierarchical manner.

1.  PEM/TEM available, SIBEC look up tables are used.
2.  PEM/TEM not available, a biophysical model (based on climate BC
    data 2002) is used. 2.1 The range of climate association is expanded
    by 5% to encompass more than the original range.

The species that are assigned a site index are those for which there is
an ecological site association for those species. This can sometimes
differ from species that are actually planted on the site. This can lead
to gaps. These missing site index values can cause an ERROR and
termination of Batch TIPSY during processing. In these cases,
alternative methods of supplying a site index are used preemptively to
prevent processing errors.

## Step1

Derive mean values

### Create feature\_id means

1.  Create raster of VRI using feature\_id
2.  Intersect all PSPL points with the feature\_id raster
3.  Derive Mean/Median (?) for each feature\_id

Call this data set the feature values.

### Create BEC zone/subzone means

1.  Group Data from the feature values into BEC zone/subzone
2.  Derive group mean

## Step 2

Fill in missing values

### Use site conversions (as per SiteTools(ref?))

Run site index conversion against each feature id to fill in missing
values.

At this point, we are not checking for specific missing values, we are
just using a brute force conversion and only running the conversion
equations once.

### Use BEC zonal averages

The site index conversions are applied against the BEC zonal means,
again to fill in missing values.  
These BEC zonal values are then applied to each feature\_id where site
index values are missing.

## Step 3

### BEC Substitutions

At this point, there will still be missing values. To overcome this, the
recommendations from Regional Ecologist were used to build an acceptable
BEC substitution (crosswalk) table.

BEC table

## Input Requirements

-   PSPL point sets by TSA
-   VRI (geometry and feature\_id in raster form)
-   BEC(x) (associated with PSPL)
-   TSA updated for additions and depletions

## Processing requirements

-   Spatially intersect PSPL with VRI features
-   Spatially intersect BEC(x) with VRI features
-   Generate mean feature\_id based PSPL site index
-   Generate BEC for each VRI feature (most points)

## Additional Site Index conversions

The application of the standard process, as described above, may still
have some gaps. These are addressed at the end of the PSPL processing or
are incorporated into the MSYT processing when aggregate curves are
built.

### Interior Western Cedar (Cw)

If there is no site index provided for Cw and the BEC zone is NOT in
CWH, CDF, or MH, then it is assigned using the White Spruce site index:

-   cw\_si = sw\_si

### Sitka Spruce

The standard PSPL process runs a set of site index conversion equations
only once. That is, the use of a converted site index is avoided if
possible. Under certain conditions, this may leave site index values
missing. In the case of Sitka Spruce (Ss), the conversion equation for
Western Hemlock(Hw) is used a second time to fill in gaps:

-   ss\_si = -4.943820220 + 1.248439450 \* hw\_si

### White Pine

Similar to Sitka Spruce, White Pine can end up with missing site index
values. In this case, two equations were required to fill in missing
site index values, one for the coast and one for the interior:

-   pw\_si = ss\_si (coastal)
-   pw\_si = fd\_si (interior)

### Yellow Pine

Also similar to Sitka Spruce, Yellow Pine can end up with missing site
index values. In this case, Douglas Fir site index is used:

-   py\_si = fd\_si

### Alder

The first discussions around missing site index values for Alder (Dr)
suggested a direct site index substitution using Douglas Fir. An
examination of these site indices lead to a discussion that possibly the
values were too high. Limited data from RPB (George Harper) suggested
the following:

-   Coast dry: bec\_zone in (‘CWH’,‘CDF’,‘MH’) and bec\_subzone in
    (‘ds’,‘db’,‘xm’)
    -   dr\_si = fd\_si \* 0.55
-   Coast Wet: bec\_zone in (‘CWH’,‘CDF’,‘MH’)
    -   dr\_si = fd\_si \* 0.73

### Shore Pine

There are occurrences of low density Shore Pine (Pl in coastal BEC).
These are being treated as Non Commercial or are being removed it they
are the last species in the list.

Examples:

CWH wh, Pl with planted density = 20 removed from planted species list

BEC zone CDF, CWH or MH, if natural species 5 is Pl, replace with Ncc

Ncc is not counted in the reported merchantable volume, but occupies
space in terms of overall site occupancy.
