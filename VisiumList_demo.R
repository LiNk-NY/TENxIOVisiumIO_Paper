# TENxVisiumList with folders ---------------------------------------------

reprex::reprex({
    suppressPackageStartupMessages(library(VisiumIO))
    sample_dirs <- list.dirs(
        system.file(
            file.path("extdata", "10xVisium"),
            package = "SpatialExperiment"
        ),
        recursive = FALSE, full.names = TRUE
    )
    tvl <- TENxVisiumList(
        sampleFolders = sample_dirs,
        sample_ids = c("sample01", "sample02"),
        processing = "raw",
        images = "lowres"
    )
    import(tvl)
}, venue = "r")


suppressPackageStartupMessages(library(VisiumIO))
sample_dirs <- list.dirs(
    system.file(
        file.path("extdata", "10xVisium"),
        package = "SpatialExperiment"
    ),
    recursive = FALSE, full.names = TRUE
)
tvl <- TENxVisiumList(
    sampleFolders = sample_dirs,
    sample_ids = c("sample01", "sample02"),
    processing = "raw",
    images = "lowres"
)
import(tvl)
#> class: SpatialExperiment
#> dim: 50 99
#> metadata(0):
#> assays(1): counts
#> rownames: NULL
#> rowData names(1): Symbol
#> colnames(99): AAACAACGAATAGTTC-1 AAACAAGTATCTCCCA-1 ...
#>   AAAGTCGACCCTCAGT-1 AAAGTGCCATCAATTA-1
#> colData names(4): in_tissue array_row array_col sample_id
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
#> imgData names(4): sample_id image_id data scaleFactor


# TENxVisium with tarballs ------------------------------------------------

## https://www.10xgenomics.com/datasets/visium-cytassist-mouse-embryo-11-mm-capture-area-ffpe-2-standard
download.file(
    "https://cf.10xgenomics.com/samples/spatial-exp/2.1.0/CytAssist_11mm_FFPE_Mouse_Embryo/CytAssist_11mm_FFPE_Mouse_Embryo_filtered_feature_bc_matrix.tar.gz",
    "~/Downloads/CytAssist_11mm_FFPE_Mouse_Embryo_filtered_feature_bc_matrix.tar.gz"
)
download.file(
    "https://cf.10xgenomics.com/samples/spatial-exp/2.1.0/CytAssist_11mm_FFPE_Mouse_Embryo/CytAssist_11mm_FFPE_Mouse_Embryo_spatial.tar.gz",
    "~/Downloads/CytAssist_11mm_FFPE_Mouse_Embryo_spatial.tar.gz"
)

reprex::reprex({
    suppressPackageStartupMessages(library(VisiumIO))
    featurebc <- "~/Downloads/CytAssist_11mm_FFPE_Mouse_Embryo_filtered_feature_bc_matrix.tar.gz"
    round(file.info(featurebc)$size / 10^6, 1) ## in MB
    spatial <- "~/Downloads/CytAssist_11mm_FFPE_Mouse_Embryo_spatial.tar.gz"
    round(file.info(spatial)$size / 10^6, 1) ## in MB
    system.time({
        visium <- TENxVisium(
            resources = featurebc, spatialResource = spatial, images = "lowres"
        )
    })
    import(visium)
}, venue = "r")

suppressPackageStartupMessages(library(VisiumIO))
featurebc <- "~/Downloads/CytAssist_11mm_FFPE_Mouse_Embryo_filtered_feature_bc_matrix.tar.gz"
round(file.info(featurebc)$size / 10^6, 1) ## in MB
#> [1] 194.6
spatial <- "~/Downloads/CytAssist_11mm_FFPE_Mouse_Embryo_spatial.tar.gz"
round(file.info(spatial)$size / 10^6, 1) ## in MB
#> [1] 36.8
system.time({
    visium <- TENxVisium(
        resources = featurebc, spatialResource = spatial, images = "lowres"
    )
})
#>    user  system elapsed
#>   1.342   0.141   1.410
import(visium)
#> class: SpatialExperiment
#> dim: 19465 6434
#> metadata(0):
#> assays(1): counts
#> rownames: NULL
#> rowData names(1): Symbol
#> colnames(6434): AACAATCCGAGTGGAC-1 AACAATGTGCTCCGAG-1 ...
#>   TGTTGGTGCGGAATCA-1 TGTTGGTGGACTCAGG-1
#> colData names(4): in_tissue array_row array_col sample_id
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
#> imgData names(4): sample_id image_id data scaleFactor


# Memory and object size --------------------------------------------------

library(pryr)
mem_change({
    sp <- import(visium)
})
#> 662 MB

library(lobstr)
obj_size(sp)
#> 654.27 MB
