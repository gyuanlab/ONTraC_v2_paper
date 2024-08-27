#! /bin/bash

# ONTraC Installation

conda create -y -n ONTraC python=3.11
conda activate ONTraC
pip install git+https://github.com/gyuanlab/ONTraC.git@V2

# Running ONTraC

mkdir -p data log analysis_output

## without kernel method

### 24-subclass

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_24ct_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_24ct_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_24ct_NTScore --n-neighbors 20 --device cuda --epochs 1000 --batch-size 10 -s 42 --patience 100 --min-delta 0.001 --min-epochs 50 --lr 0.03 --hidden-feats 4 -k 6 --modularity-loss-weight 1 --regularization-loss-weight 0.1  --purity-loss-weight 30 --beta 0.3 --equal-space 2>&1 | tee log/merfish_mouse1_slice221_20_neighbors_24ct.log
ONTraC_analysis -o analysis_output/merfish_mouse1_slice221_20_neighbors_24ct -l log/merfish_mouse1_slice221_20_neighbors_24ct.log --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_24ct_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_24ct_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_24ct_NTScore --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 99-label

ONTraC --meta-input merfish_mouse1_slice221_99_label_meta.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_99ct_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_99ct_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_99ct_NTScore --n-neighbors 20 --device cuda --epochs 1000 --batch-size 10 -s 42 --patience 100 --min-delta 0.001 --min-epochs 50 --lr 0.03 --hidden-feats 4 -k 6 --modularity-loss-weight 1 --regularization-loss-weight 0.1  --purity-loss-weight 30 --beta 0.3 --equal-space 2>&1 | tee log/merfish_mouse1_slice221_20_neighbors_99ct.log
ONTraC_analysis -o analysis_output/merfish_mouse1_slice221_20_neighbors_99ct -l log/merfish_mouse1_slice221_20_neighbors_99ct.log --meta-input merfish_mouse1_slice221_99_label_meta.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_99ct_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_99ct_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_99ct_NTScore --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 126-cluster

ONTraC --meta-input merfish_mouse1_slice221_126_cluster_meta.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_126ct_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_126ct_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_126ct_NTScore --n-neighbors 20 --device cuda --epochs 1000 --batch-size 10 -s 42 --patience 100 --min-delta 0.001 --min-epochs 50 --lr 0.03 --hidden-feats 4 -k 6 --modularity-loss-weight 1 --regularization-loss-weight 0.1  --purity-loss-weight 30 --beta 0.3 --equal-space 2>&1 | tee log/merfish_mouse1_slice221_20_neighbors_126ct.log
ONTraC_analysis -o analysis_output/merfish_mouse1_slice221_20_neighbors_126ct -l log/merfish_mouse1_slice221_20_neighbors_126ct.log --meta-input merfish_mouse1_slice221_126_cluster_meta.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_126ct_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_126ct_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_126ct_NTScore --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 361-cluster

ONTraC --meta-input merfish_mouse1_slice221_361_cluster_meta.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_361ct_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_361ct_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_361ct_NTScore --n-neighbors 20 --device cuda --epochs 1000 --batch-size 10 -s 42 --patience 100 --min-delta 0.001 --min-epochs 50 --lr 0.03 --hidden-feats 4 -k 6 --modularity-loss-weight 1 --regularization-loss-weight 0.1  --purity-loss-weight 30 --beta 0.3 --equal-space 2>&1 | tee log/merfish_mouse1_slice221_20_neighbors_361ct.log
ONTraC_analysis -o analysis_output/merfish_mouse1_slice221_20_neighbors_361ct -l log/merfish_mouse1_slice221_20_neighbors_361ct.log --meta-input merfish_mouse1_slice221_361_cluster_meta.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_361ct_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_361ct_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_361ct_NTScore --suppress-cell-type-composition --suppress-niche-cluster-loadings

## with kernel method

### 24-subclass

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_24ct_kernel_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_24ct_kernel_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_24ct_kernel_NTScore --n-neighbors 20 --embedding-adjust --sigma 1 --device cuda --epochs 1000 --batch-size 10 -s 42 --patience 100 --min-delta 0.001 --min-epochs 50 --lr 0.03 --hidden-feats 4 -k 6 --modularity-loss-weight 1 --regularization-loss-weight 0.1  --purity-loss-weight 30 --beta 0.3 --equal-space 2>&1 | tee log/merfish_mouse1_slice221_20_neighbors_24ct_kernel.log
ONTraC_analysis -o analysis_output/merfish_mouse1_slice221_20_neighbors_24ct_kernel -l log/merfish_mouse1_slice221_20_neighbors_24ct_kernel.log --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_24ct_kernel_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_24ct_kernel_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_24ct_kernel_NTScore  --embedding-adjust --sigma 1 --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 99-label

ONTraC --meta-input merfish_mouse1_slice221_99_label_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_99ct_kernel_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_99ct_kernel_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_99ct_kernel_NTScore --n-neighbors 20 --embedding-adjust --sigma 1 --device cuda --epochs 1000 --batch-size 10 -s 42 --patience 100 --min-delta 0.001 --min-epochs 50 --lr 0.03 --hidden-feats 4 -k 6 --modularity-loss-weight 1 --regularization-loss-weight 0.1  --purity-loss-weight 30 --beta 0.3 --equal-space 2>&1 | tee log/merfish_mouse1_slice221_20_neighbors_99ct_kernel.log
ONTraC_analysis -o analysis_output/merfish_mouse1_slice221_20_neighbors_99ct_kernel -l log/merfish_mouse1_slice221_20_neighbors_99ct_kernel.log --meta-input merfish_mouse1_slice221_99_label_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_99ct_kernel_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_99ct_kernel_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_99ct_kernel_NTScore  --embedding-adjust --sigma 1 --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 126-cluster

ONTraC --meta-input merfish_mouse1_slice221_126_cluster_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_126ct_kernel_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_126ct_kernel_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_126ct_kernel_NTScore --n-neighbors 20 --embedding-adjust --sigma 1 --device cuda --epochs 1000 --batch-size 10 -s 42 --patience 100 --min-delta 0.001 --min-epochs 50 --lr 0.03 --hidden-feats 4 -k 6 --modularity-loss-weight 1 --regularization-loss-weight 0.1  --purity-loss-weight 30 --beta 0.3 --equal-space 2>&1 | tee log/merfish_mouse1_slice221_20_neighbors_126ct_kernel.log
ONTraC_analysis -o analysis_output/merfish_mouse1_slice221_20_neighbors_126ct_kernel -l log/merfish_mouse1_slice221_20_neighbors_126ct_kernel.log --meta-input merfish_mouse1_slice221_126_cluster_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_126ct_kernel_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_126ct_kernel_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_126ct_kernel_NTScore  --embedding-adjust --sigma 1 --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 361-cluster

ONTraC --meta-input merfish_mouse1_slice221_361_cluster_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_361ct_kernel_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_361ct_kernel_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_361ct_kernel_NTScore --n-neighbors 20 --embedding-adjust --sigma 1 --device cuda --epochs 1000 --batch-size 10 -s 42 --patience 100 --min-delta 0.001 --min-epochs 50 --lr 0.03 --hidden-feats 4 -k 6 --modularity-loss-weight 1 --regularization-loss-weight 0.1  --purity-loss-weight 30 --beta 0.3 --equal-space 2>&1 | tee log/merfish_mouse1_slice221_20_neighbors_361ct_kernel.log
ONTraC_analysis -o analysis_output/merfish_mouse1_slice221_20_neighbors_361ct_kernel -l log/merfish_mouse1_slice221_20_neighbors_361ct_kernel.log --meta-input merfish_mouse1_slice221_361_cluster_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/merfish_mouse1_slice221_20_neighbors_361ct_kernel_preprocessing --GNN-dir output/merfish_mouse1_slice221_20_neighbors_361ct_kernel_GNN --NTScore-dir output/merfish_mouse1_slice221_20_neighbors_361ct_kernel_NTScore  --embedding-adjust --sigma 1 --suppress-cell-type-composition --suppress-niche-cluster-loadings

# example for different types of input

## meta input only

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --preprocessing-dir data/V2_example_meta_input_preprocessing --GNN-dir output/V2_example_meta_input_GNN --NTScore-dir output/V2_example_meta_input_NTScore --embedding-adjust -s 42 --equal-space 2>&1 | tee log/V2_example_meta_input.log
ONTraC_analysis -o analysis_output/V2_example_meta_input -l log/V2_example_meta_input.log --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --preprocessing-dir data/V2_example_meta_input_preprocessing --GNN-dir output/V2_example_meta_input_GNN --NTScore-dir output/V2_example_meta_input_NTScore --suppress-cell-type-composition --suppress-niche-cluster-loadings

## meta data with given embeedings

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/V2_example_embedding_input_preprocessing --GNN-dir output/V2_example_embedding_input_GNN --NTScore-dir output/V2_example_embedding_input_NTScore  --embedding-adjust -s 42 --equal-space 2>&1 | tee log/V2_example_embedding_input.log
ONTraC_analysis -o analysis_output/V2_example_embedding_input -l log/V2_example_embedding_input.log --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --preprocessing-dir data/V2_example_embedding_input_preprocessing --GNN-dir output/V2_example_embedding_input_GNN --NTScore-dir output/V2_example_embedding_input_NTScore --suppress-cell-type-composition --suppress-niche-cluster-loadings

## meta data with gene expression

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --exp-input mouse1_slice221_counts.csv --preprocessing-dir data/V2_example_exp_input_preprocessing --GNN-dir output/V2_example_exp_input_GNN --NTScore-dir output/V2_example_exp_input_NTScore --resolution 1 --embedding-adjust -s 42 --equal-space 2>&1 | tee log/V2_example_exp_input.log
ONTraC_analysis -o analysis_output/V2_example_exp_input -l log/V2_example_exp_input.log --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --exp-input mouse1_slice221_counts.csv --preprocessing-dir data/V2_example_exp_input_preprocessing --GNN-dir output/V2_example_exp_input_GNN --NTScore-dir output/V2_example_exp_input_NTScore --suppress-cell-type-composition --suppress-niche-cluster-loadings
