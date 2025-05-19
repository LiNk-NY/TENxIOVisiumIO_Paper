# TENxVisiumList with folders ---------------------------------------------
setwd("~/Downloads")

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
