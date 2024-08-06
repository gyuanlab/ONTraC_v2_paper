# Figure 3
# CosMx Non-Small Single-Cell Lung adenocarcinoma dataset 


##%######################################################%##
#                                                          #
####       Download the processed Giotto object         ####
#                                                          #
##%######################################################%##

# Download the processed Giotto object from the cosmx website:
# https://nanostring.com/products/cosmx-spatial-molecular-imager/ffpe-dataset/nsclc-ffpe-dataset/

##%######################################################%##
#                                                          #
####     Load the Rdata file from the Giotto object     ####
#                                                          #
##%######################################################%##

# Load Giotto    
library(Giotto)

load("Processed Data Giotto Object/SMI_Giotto_Object.RData")

# Get the expression matrix, metadata, PCA, and spatial locations
raw_expression <- gem@expression$rna$raw
gem_pca <- as.data.frame(gem@dimension_reduction$cells$pca$pca$coordinates)
metadata <- gem@cell_metadata$rna
coordinates <- gem@spatial_locs$raw

##%######################################################%##
#                                                          #
#### Create a new Giotto object and subset the dataset  ####
#                                                          #
##%######################################################%##

new_giotto_object <- createGiottoObject(expression = raw_expression,
                                        spatial_locs = coordinates)

new_giotto_object <- addCellMetadata(new_giotto_object,
                                     new_metadata = metadata[,-1])

new_giotto_object <- setDimReduction(new_giotto_object,
                                     x = createDimObj(coordinates = gem_pca,
                                                      name = "pca"),
                                     name = "pca",
                                     reduction_method = "pca")

lung_6_cells <- metadata[metadata$patient == "Lung6",]$cell_ID

new_giotto_object <- subsetGiotto(new_giotto_object,
                                  cell_ids = lung_6_cells)

##%######################################################%##
#                                                          #
####            Create the tables for ontrac             ###
#                                                          #
##%######################################################%##

metadata <- pDataDT(new_giotto_object)

coordinates <- getSpatialLocations(new_giotto_object,
                                   output = "data.table")

pca_table <- as.data.frame(getDimReduction(new_giotto_object,
                                           reduction_method = "pca",
                                           name = "pca",
                                           output = "matrix"))

# create pca embeddings tables
embeddings_data <- data.frame(Cell_ID = metadata$cell_ID,
                              Embedding_1 = pca_table$Dim.1,
                              Embedding_2 = pca_table$Dim.2,
                              Embedding_3 = pca_table$Dim.3,
                              Embedding_4 = pca_table$Dim.4,
                              Embedding_5 = pca_table$Dim.5,
                              Embedding_6 = pca_table$Dim.6,
                              Embedding_7 = pca_table$Dim.7,
                              Embedding_8 = pca_table$Dim.8,
                              Embedding_9 = pca_table$Dim.9,
                              Embedding_10 = pca_table$Dim.10)

metadata_embeddings <- data.frame(Cell_ID = metadata$cell_ID,
                                  Sample = metadata$patient,
                                  Cell_Type = metadata$cell_type,
                                  x = coordinates$sdimx,
                                  y = coordinates$sdimy)

write.table(embeddings_data, 
            "embeddings_data.csv", sep = ",", 
            quote = FALSE, row.names = FALSE, col.names = TRUE)

write.table(metadata_embeddings, 
            "metadata_embeddings.csv", sep = ",", 
            quote = FALSE, row.names = FALSE, col.names = TRUE)

##%######################################################%##
#                                                          #
####                     Run ONTraC                     ####
#                                                          #
##%######################################################%##

# Run ONTraC using pca embeddings

## bash code
ONTraC --meta-input metadata_embeddings.csv \
--embedding-input embeddings_data.csv \
--preprocessing-dir data_lung6_pca/lung_final_preprocessing_dir \
--GNN-dir output_lung6_pca/lung_final_GNN \
--NTScore-dir output_lung6_pca/lung_final_NTScore \
--device cpu --epochs 400 -s 42 --patience 100 \
--min-delta 0.001 --min-epochs 50 --lr 0.03 --hidden-feats 4 \
-k 4 --n-neighbors 200 --sigma 2 \
--beta 0.3 --equal-space 2>&1 | tee lung_final.log

ONTraC_analysis --meta-input metadata_embeddings.csv \
--embedding-input embeddings_data.csv \
--preprocessing-dir data_lung6_pca/lung_final_preprocessing_dir \
--GNN-dir output_lung6_pca/lung_final_GNN \
--NTScore-dir output_lung6_pca/lung_final_NTScore \
-o analysis_lung6_pca -l lung_final.log

##%######################################################%##
#                                                          #
####             Find top expressed genes               ####
#                                                          #
##%######################################################%##

# re-calculate the normalization step to obtain the scaled matrix

new_giotto_object <- normalizeGiotto(new_giotto_object)

scran_markers <- findMarkers_one_vs_all(new_giotto_object,
                                        cluster_column = "cell_type",
                                        method = "scran")

# top 2 marker genes per cell type
head(scran_markers[scran_markers$cluster == "epithelial",]) # CD74, SERPINA1

head(scran_markers[scran_markers$cluster == "macrophage",]) # CD74, CD68

head(scran_markers[scran_markers$cluster == "tumor 6",]) # EGFR, KRT17

# Create spatial plots

library(ggplot2)
library(dplyr)

# create a table with metadata and scaled expression
nt_score <- read.csv("output_lung6_pca/lung_final_NTScore/Lung6_NTScore.csv.gz")

scaled_expression <- as.data.frame(t(as.matrix(getExpression(new_giotto_object,
                                                             values = "scaled",
                                                             output = "matrix"))))

normalized_expression <- as.data.frame(t(as.matrix(getExpression(new_giotto_object,
                                                                 values = "normalized",
                                                                 output = "matrix"))))

nt_score$cell_type <- metadata$cell_type
nt_score$EGFR <- scaled_expression$EGFR
nt_score$CD68 <- scaled_expression$CD68
nt_score$SERPINA1 <- scaled_expression$SERPINA1

## Macrophages
nt_score %>% 
  ggplot(aes(x, y, color = CD68)) +
  geom_point(size = 0.4) +
  labs(title = "CD68",
       color = "") +
  scale_color_gradient2(low = "blue",
                        high = "red",
                        limits = c(-2,2),
                        na.value = "red") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 26),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks.length = unit(0, "in"),
        panel.border = element_rect(linewidth = 2)) 
ggsave("analysis_lung6_pca/expression_cd68.png",
       scale = 1, dpi = 300, width = 8, height = 7)

## Epithelial
nt_score %>% 
  ggplot(aes(x, y, color = SERPINA1)) +
  geom_point(size = 0.4) +
  labs(title = "SERPINA1",
       color = "") +
  scale_color_gradient2(low = "blue",
                        high = "red",
                        limits = c(-2,2),
                        na.value = "red") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 26),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks.length = unit(0, "in"),
        panel.border = element_rect(linewidth = 2)) 
ggsave("analysis_lung6_pca/expression_serpina1.png",
       scale = 1, dpi = 300, width = 8, height = 7)


## Tumor cell 
nt_score %>% 
  ggplot(aes(x, y, color = EGFR)) +
  geom_point(size = 0.4) +
  labs(title = "EGFR",
       color = "") +
  scale_color_gradient2(low = "blue",
                        high = "red",
                        limits = c(-2,2),
                        na.value = "red") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 26),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks.length = unit(0, "in"),
        panel.border = element_rect(linewidth = 2)) 
ggsave("analysis_lung6_pca/expression_egfr.png",
       scale = 1, dpi = 300, width = 8, height = 7)


##%######################################################%##
#                                                          #
####            Expression vs NT score plots            ####
#                                                          #
##%######################################################%##

# calculate the correlation between NT score and expression levels
normalized_expression <- as.data.frame(t(as.matrix(
  getExpression(new_giotto_object,
                values = "normalized",
                output = "matrix"))))

pearson_correlations <- data.frame(gene = "a",
                                   estimate = 1,
                                   pvalue = 1
                                   )

for(gene in colnames(normalized_expression)) {
  pearson_result <- cor.test(x = normalized_expression[[gene]], 
                        y = nt_score$Cell_NTScore, 
                        method = "pearson")
  
  if(pearson_result$p.value <= 0.05) {
    pearson_correlations <- rbind(pearson_correlations,
                                  c(gene,
                                    pearson_result$estimate,
                                    pearson_result$p.value
                                    ))
  }
  
}

pearson_correlations <- pearson_correlations[-1,]

# plot top positive correlation
pearson_correlations %>% 
  arrange(desc(estimate)) %>% 
  head(10) # EGFR, KRT17

normalized_expression$ntscore <- nt_score$Cell_NTScore

normalized_expression %>% 
  filter(EGFR > 0) %>% 
  ggplot(aes(ntscore, EGFR)) +
  geom_point(size = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 2) +
  labs(title = "EGFR",
       x = "Cell NT Score",
       y = "Expression") +
  scale_y_continuous(limits = c(0,11), breaks = c(0,2,4,6,8,10)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 26),
        axis.title = element_text(size = 26),
        axis.text = element_text(size = 26),
        panel.border = element_rect(linewidth = 2))
ggsave("analysis_lung6_pca/scatterplot_EGFR.png",
       scale = 1, dpi = 300, width = 8, height = 7)

normalized_expression %>% 
  filter(KRT17 > 0) %>% 
  ggplot(aes(ntscore, KRT17)) +
  geom_point(size = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 2) +
  labs(title = "KRT17",
       x = "Cell NT Score",
       y = "Expression") +
  scale_y_continuous(limits = c(0,11), breaks = c(0,2,4,6,8,10)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 26),
        axis.title = element_text(size = 26),
        axis.text = element_text(size = 26),
        panel.border = element_rect(linewidth = 2))
ggsave("analysis_lung6_pca/scatterplot_KRT17.png",
       scale = 1, dpi = 300, width = 8, height = 7)

# plot top negative correlation
pearson_correlations %>% 
  filter(estimate < 0) %>% 
  arrange(desc(estimate)) %>% 
  head(10) # CD74, HLA-DRB1

normalized_expression %>% 
  filter(CD74 > 0) %>% 
  ggplot(aes(ntscore, CD74)) +
  geom_point(size = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 2) +
  labs(title = "CD74",
       x = "Cell NT Score",
       y = "Expression") +
  scale_y_continuous(limits = c(0,11), breaks = c(0,2,4,6,8,10)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 26),
        axis.title = element_text(size = 26),
        axis.text = element_text(size = 26),
        panel.border = element_rect(linewidth = 2))
ggsave("analysis_lung6_pca/scatterplot_CD74.png",
       scale = 1, dpi = 300, width = 8, height = 7)

normalized_expression %>% 
  filter(`HLA-DRB1` > 0) %>% 
  ggplot(aes(ntscore, `HLA-DRB1`)) +
  geom_point(size = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 2) +
  labs(title = "HLA-DRB1",
       x = "Cell NT Score",
       y = "Expression") +
  scale_y_continuous(limits = c(0,11), breaks = c(0,2,4,6,8,10)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 26),
        axis.title = element_text(size = 26),
        axis.text = element_text(size = 26),
        panel.border = element_rect(linewidth = 2))
ggsave("analysis_lung6_pca/scatterplot_HLA-DRB1.png",
       scale = 1, dpi = 300, width = 8, height = 7)

