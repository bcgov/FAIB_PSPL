[![img](https://img.shields.io/badge/Lifecycle-Experimental-339999)](https://github.com/bcgov/repomountie/blob/master/doc/lifecycle-badges.md)
## FAIB_PSPL

### Provincial Site Productivity Layer (PSPL) augmentation for producing Managed Stand Yield Tables (MSYTs)

https://www2.gov.bc.ca/gov/content/industry/forestry/managing-our-forest-resources/forest-inventory/site-productivity/provincial-site-productivity-layer

The PSPL as published described above, provides an estimate of the site index for 22 species.  PEM/TEM mapping plus a bio-physical model attempts to fill in gaps where data is lacking.  For various reasons, there can still be gaps.  These can be due to lack of a biophysical representation in a specific BEC zone/subzone.  The main example of this being the SWB area where neither  PEM/TEM nor a biophysical model exit.  

The bio-physical model has a specific calibration range.  This means that stands outside of the range will not be assigned site index values.  

In addition, there are examples of species being planted that are not in the list of ecologically expected species.  Again, this means that site index values may not be available.

### Filling in Gaps

The purpose of this project is to fill in all remaining gaps. When a species composition is derived from RESULTS for a MSYT, there will always be a site index for each species.

The code in this github is open-source and provides a transparent record of the PSPL augmentation process. Anyone is free to download, reproduce and apply the methods. However, this is not a self-contained piece of software. In particular, additional data is required beyond that which is available from Data BC. 


### Core Team
Dave Waddell, Modelling Forester, Forest Analysis and Inventory Branch, Office of the Chief Forester, Ministry of Forests.   

Iaian Mcdougall,  Spatial Data Specialist, Forest Analysis and Inventory Branch, Office of the Chief Forester, Ministry of Forests.  

### Requirements
The model is coded using the R programming language. Thus, you will need to [download program R](https://cran.r-project.org/bin/windows/base/) to work with the code, but don't worry, it's free, open-source software. We also recommend downloading the free version of [RStudio](https://rstudio.com/products/rstudio/download/), which provides a nice integrated development environment for working with R.   

### License
Copyright 2020-2021 Province of British Columbia

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at 

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.