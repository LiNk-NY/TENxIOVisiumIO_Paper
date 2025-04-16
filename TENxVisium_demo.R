setwd("~/Downloads")

## https://www.10xgenomics.com/datasets/visium-cytassist-mouse-embryo-11-mm-capture-area-ffpe-2-standard
download.file(
    paste0(
        "https://cf.10xgenomics.com/samples/spatial-exp/2.1.0/",
        "CytAssist_11mm_FFPE_Mouse_Embryo/CytAssist_11mm_FFPE_Mouse_Embryo_filtered_feature_bc_matrix.tar.gz"
    ),
    "CytAssist_11mm_FFPE_Mouse_Embryo_filtered_feature_bc_matrix.tar.gz"
)
download.file(
    paste0(
        "https://cf.10xgenomics.com/samples/spatial-exp/2.1.0/",
        "CytAssist_11mm_FFPE_Mouse_Embryo/CytAssist_11mm_FFPE_Mouse_Embryo_spatial.tar.gz"
    ),
    "CytAssist_11mm_FFPE_Mouse_Embryo_spatial.tar.gz"
)

# TENxVisium with tarballs ------------------------------------------------

reprex::reprex({
    setwd("~/Downloads")
    suppressPackageStartupMessages(library(VisiumIO))
    featurebc <-
        "CytAssist_11mm_FFPE_Mouse_Embryo_filtered_feature_bc_matrix.tar.gz"
    spatial <- "CytAssist_11mm_FFPE_Mouse_Embryo_spatial.tar.gz"
    vfl <- TENxVisium(
        resources = featurebc, spatialResource = spatial, images = "cytassist"
    )
    import(vfl)
}, venue = "r")

#> class: SpatialExperiment
#> dim: 19465 6434
#> metadata(2): resources spatialList
#> assays(1): counts
#> rownames(19465): ENSMUSG00000051951 ENSMUSG00000025900 ... ENSMUSG00000096520 ENSMUSG00000096686
#> rowData names(3): ID Symbol Type
#> colnames(6434): AACAATCCGAGTGGAC-1 AACAATGTGCTCCGAG-1 ... TGTTGGTGCGGAATCA-1 TGTTGGTGGACTCAGG-1
#> colData names(4): in_tissue array_row array_col sample_id
#> reducedDimNames(0):
#>     mainExpName: Gene Expression
#> altExpNames(0):
#>     spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
#> imgData names(4): sample_id image_id data scaleFactor


# Metrics -----------------------------------------------------------------

round(file.info(featurebc)$size / 10^6, 1) ## in MB
#> [1] 194.6
round(file.info(spatial)$size / 10^6, 1) ## in MB
#> [1] 36.8
visium <- TENxVisium(
    resources = featurebc, spatialResource = spatial, images = "cytassist"
)
system.time({
    import(visium)
})
#> user  system elapsed
#> 24.222   1.774  25.894

# Memory and object size --------------------------------------------------

library(pryr)
mem_change({
    sp <- import(visium)
})
#> 662 MB

library(lobstr)
obj_size(sp)
#> 656.30 MB
