# ONTraC v2 paper files

## What's new in ONTraC v2

- Overcoming cell-type annotation variations

ONTraC v1 takes cell-type annotation information as input, which may contains technical variations due to the lack of standrad cell-type annotation procedure. ONTraC v2 take use of kernel-based approach to model niche properties, thereby eliminating the influence of cell-type annotation variations.

- Supporting lower spatial resolution data

ONTraC v2 can takes the cell-type deconvolution results as input which extends its support to lower spatial resolution data.

## ONTraC installation

### Create and enter conda env (recommend)

```sh
conda create -y -n ONTraC python=3.11
conda activate ONTraC
```

#### Add this kernel to jupyter (recommend)

```sh
pip install ipykernel
python -m ipykernel install --user --name ONTraC --display-name "Python 3.11 (ONTraC)"
```

### Install ONTraC

```sh
pip install git+https://github.com/gyuanlab/ONTraC.git@V2
```
