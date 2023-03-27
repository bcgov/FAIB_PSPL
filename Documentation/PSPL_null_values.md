# NULL values in PSPL

## Processing order

The assignment of site index follows the following sequence:  

- PEM/TEM
- Biophysical model

If a PEM or TEM does not exists, then the Biophysical model is applied.   

If a Biophysical model does not exist for the given BEC, then NULL values are generated for all species site index values.  

If the Biophysical model exists for the given BEC, but the climate data is outside the given range of pramaterization, then NULL values are generated for all speices.
