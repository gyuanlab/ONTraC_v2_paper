# Part1 reproduce code

## Preprocessing

- [Preprocessing codes](./Step0_preprocessing.ipynb)

This notebook contains codes for downloading data, calculating center and cortical depth for each cell, generating cell clusters and input for ONTraC.

## Running ONTraC and other methods

- [ONTraC running command](./Step1_run_ONTraC.sh)

This script contains codes for running ONTraC for each settings.

- [spaceFlow running codes](./Step1_spaceFlow.ipynb)

This notebook contains codes about how to run [spaceFlow](https://www.nature.com/articles/s41467-022-31739-w).

- [other R-based pseudotime methods running codes](./Step1_other_pseudotime_methods.ipynb)

This notebook contains codes about how to run [diffusionMap](http://bioinformatics.oxfordjournals.org/content/32/8/1241), [monocle](https://www.nature.com/articles/s41586-019-0969-x), [TSCAN](https://academic.oup.com/nar/article/44/13/e117/2457590), and [SpatialPCA](https://www.nature.com/articles/s41467-022-34879-1).

## Calculating correlation with cortical depth

- [Analysis codes](./Step2_integrate_results.ipynb)

This notebook contains codes for calculating correlation between NTScore, pseudotime values and cortical depth.
