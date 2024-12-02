#! /bin/bash

# ONTraC Installation

conda create -y -n ONTraC python=3.11
conda activate ONTraC
pip install "ONTraC[analysis]==2.0rc6"

# Running ONTraC

mkdir -p output log analysis_output

## without kernel method

### 24-subclass

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --NN-dir output/mouse1_slice221_24_subclass_no_kernel_NN --GNN-dir output/mouse1_slice221_24_subclass_no_kernel_GNN --NT-dir output/mouse1_slice221_24_subclass_no_kernel_NT --n-neighbors 20 -s 42 --equal-space 2>&1 | tee log/mouse1_slice221_24_subclass_no_kernel.log
ONTraC_analysis -o analysis_output/mouse1_slice221_24_subclass_no_kernel -l log/mouse1_slice221_24_subclass_no_kernel.log --NN-dir output/mouse1_slice221_24_subclass_no_kernel_NN --GNN-dir output/mouse1_slice221_24_subclass_no_kernel_GNN --NT-dir output/mouse1_slice221_24_subclass_no_kernel_NT -s --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 99-label

ONTraC --meta-input merfish_mouse1_slice221_99_label_meta.csv --NN-dir output/mouse1_slice221_99_label_no_kernel_NN --GNN-dir output/mouse1_slice221_99_label_no_kernel_GNN --NT-dir output/mouse1_slice221_99_label_no_kernel_NT --n-neighbors 20 -s 42 --equal-space 2>&1 | tee log/merfish_mouse1_slice221_20_neighbors_99ct.log
ONTraC_analysis -o analysis_output/mouse1_slice221_99_label_no_kernel -l log/mouse1_slice221_99_label_no_kernel.log --NN-dir output/mouse1_slice221_99_label_no_kernel_NN --GNN-dir output/mouse1_slice221_99_label_no_kernel_GNN --NT-dir output/mouse1_slice221_99_label_no_kernel_NT -s --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 126-cluster

ONTraC --meta-input merfish_mouse1_slice221_126_cluster_meta.csv --NN-dir output/mouse1_slice221_126_cluster_no_kernel_NN --GNN-dir output/mouse1_slice221_126_cluster_no_kernel_GNN --NT-dir output/mouse1_slice221_126_cluster_no_kernel_NT --n-neighbors 20 -s 42 --equal-space 2>&1 | tee log/mouse1_slice221_126_cluster_no_kernel.log
ONTraC_analysis -o analysis_output/mouse1_slice221_126_cluster_no_kernel -l log/mouse1_slice221_126_cluster_no_kernel.log --NN-dir output/mouse1_slice221_126_cluster_no_kernel_NN --GNN-dir output/mouse1_slice221_126_cluster_no_kernel_GNN --NT-dir output/mouse1_slice221_126_cluster_no_kernel_NT -s --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 361-cluster

ONTraC --meta-input merfish_mouse1_slice221_361_cluster_meta.csv --NN-dir output/mouse1_slice221_361_cluster_no_kernel_NN --GNN-dir output/mouse1_slice221_361_cluster_no_kernel_GNN --NT-dir output/mouse1_slice221_361_cluster_no_kernel_NT --n-neighbors 20 -s 42 --equal-space 2>&1 | tee log/mouse1_slice221_361_cluster_no_kernel.log
ONTraC_analysis -o analysis_output/mouse1_slice221_361_cluster_no_kernel -l log/mouse1_slice221_361_cluster_no_kernel.log --NN-dir output/mouse1_slice221_361_cluster_no_kernel_NN --GNN-dir output/mouse1_slice221_361_cluster_no_kernel_GNN --NT-dir output/mouse1_slice221_361_cluster_no_kernel_NT -s --suppress-cell-type-composition --suppress-niche-cluster-loadings

## with kernel method

### 24-subclass

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --NN-dir output/mouse1_slice221_24_subclass_with_kernel_NN --GNN-dir output/mouse1_slice221_24_subclass_with_kernel_GNN --NT-dir output/mouse1_slice221_24_subclass_with_kernel_NT --n-neighbors 20 --embedding-adjust --sigma 1 -s 42 --equal-space 2>&1 | tee log/mouse1_slice221_24_subclass_with_kernel.log
ONTraC_analysis -o analysis_output/mouse1_slice221_24_subclass_with_kernel -l log/mouse1_slice221_24_subclass_with_kernel.log --NN-dir output/mouse1_slice221_24_subclass_with_kernel_NN --GNN-dir output/mouse1_slice221_24_subclass_with_kernel_GNN --NT-dir output/mouse1_slice221_24_subclass_with_kernel_NT --embedding-adjust --sigma 1 -s --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 99-label

ONTraC --meta-input merfish_mouse1_slice221_99_label_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --NN-dir output/mouse1_slice221_99_label_with_kernel_NN --GNN-dir output/mouse1_slice221_99_label_with_kernel_GNN --NT-dir output/mouse1_slice221_99_label_with_kernel_NT --n-neighbors 20 --embedding-adjust --sigma 1 -s 42 --equal-space 2>&1 | tee log/mouse1_slice221_99_label_with_kernel.log
ONTraC_analysis -o analysis_output/mouse1_slice221_99_label_with_kernel -l log/mouse1_slice221_99_label_with_kernel.log --NN-dir output/mouse1_slice221_99_label_with_kernel_NN --GNN-dir output/mouse1_slice221_99_label_with_kernel_GNN --NT-dir output/mouse1_slice221_99_label_with_kernel_NT --embedding-adjust --sigma 1 -s --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 126-cluster

ONTraC --meta-input merfish_mouse1_slice221_126_cluster_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --NN-dir output/mouse1_slice221_126_cluster_with_kernel_NN --GNN-dir output/mouse1_slice221_126_cluster_with_kernel_GNN --NT-dir output/mouse1_slice221_126_cluster_with_kernel_NT --n-neighbors 20 --embedding-adjust --sigma 1 -s 42 --equal-space 2>&1 | tee log/mouse1_slice221_126_cluster_with_kernel.log
ONTraC_analysis -o analysis_output/mouse1_slice221_126_cluster_with_kernel -l log/mouse1_slice221_126_cluster_with_kernel.log --NN-dir output/mouse1_slice221_126_cluster_with_kernel_NN --GNN-dir output/mouse1_slice221_126_cluster_with_kernel_GNN --NT-dir output/mouse1_slice221_126_cluster_with_kernel_NT --embedding-adjust --sigma 1 -s --suppress-cell-type-composition --suppress-niche-cluster-loadings

### 361-cluster

ONTraC --meta-input merfish_mouse1_slice221_361_cluster_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --NN-dir output/mouse1_slice221_361_cluster_with_kernel_NN --GNN-dir output/mouse1_slice221_361_cluster_with_kernel_GNN --NT-dir output/mouse1_slice221_361_cluster_with_kernel_NT --n-neighbors 20 --embedding-adjust --sigma 1 -s 42 --equal-space 2>&1 | tee log/mouse1_slice221_361_cluster_with_kernel.log
ONTraC_analysis -o analysis_output/mouse1_slice221_361_cluster_with_kernel -l log/mouse1_slice221_361_cluster_with_kernel.log --NN-dir output/mouse1_slice221_361_cluster_with_kernel_NN --GNN-dir output/mouse1_slice221_361_cluster_with_kernel_GNN --NT-dir output/mouse1_slice221_361_cluster_with_kernel_NT --embedding-adjust --sigma 1 -s --suppress-cell-type-composition --suppress-niche-cluster-loadings

# example for different types of input

## meta input only

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --NN-dir output/V2_example_meta_input_NN --GNN-dir output/V2_example_meta_input_GNN --NT-dir output/V2_example_meta_input_NT --equal-space 2>&1 | tee log/V2_example_meta_input.log
ONTraC_analysis -o analysis_output/V2_example_meta_input -l log/V2_example_meta_input.log --NN-dir output/V2_example_meta_input_NN --GNN-dir output/V2_example_meta_input_GNN --NT-dir output/V2_example_meta_input_NT -s --suppress-cell-type-composition --suppress-niche-cluster-loadings

## meta data with given embeedings

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --embedding-input merfish_mouse1_slice221_embedding.csv --NN-dir data/V2_example_embedding_input_NN --GNN-dir output/V2_example_embedding_input_GNN --NT-dir output/V2_example_embedding_input_NT  --embedding-adjust --equal-space 2>&1 | tee log/V2_example_embedding_input.log
ONTraC_analysis -o analysis_output/V2_example_embedding_input -l log/V2_example_embedding_input.log --NN-dir data/V2_example_embedding_input_NN --GNN-dir output/V2_example_embedding_input_GNN --NT-dir output/V2_example_embedding_input_NT -s --embedding-adjust --sigma 1 --suppress-cell-type-composition --suppress-niche-cluster-loadings

## meta data with gene expression

ONTraC --meta-input merfish_mouse1_slice221_24_subclass_meta.csv --exp-input mouse1_slice221_counts.csv --NN-dir data/V2_example_exp_input_NN --GNN-dir output/V2_example_exp_input_GNN --NT-dir output/V2_example_exp_input_NT --resolution 1 --embedding-adjust -s 42 --equal-space 2>&1 | tee log/V2_example_exp_input.log
ONTraC_analysis -o analysis_output/V2_example_exp_input -l log/V2_example_exp_input.log --NN-dir data/V2_example_exp_input_NN --GNN-dir output/V2_example_exp_input_GNN --NT-dir output/V2_example_exp_input_NT --embedding-adjust --sigma 1 -s --suppress-cell-type-composition --suppress-niche-cluster-loadings
