setwd("~/Downloads")

download.file(
    url = paste0(
        "https://mghp.osn.xsede.org/bir190004-bucket01/BiocXenDemo/",
        "Xenium_Prime_MultiCellSeg_Mouse_Ileum_tiny_outs.zip"
    ),
    destfile =
        "Xenium_Prime_MultiCellSeg_Mouse_Ileum_tiny_outs.zip"
)

reprex::reprex({
    setwd("~/Downloads")
    tinyouts <-
        "Xenium_Prime_MultiCellSeg_Mouse_Ileum_tiny_outs.zip"
    suppressPackageStartupMessages(library(XeniumIO))
    unzip(
        zipfile = tinyouts,
        exdir = outfold <- file.path(tempdir(), tinyouts),
        overwrite = FALSE
    )
    TENxXenium(xeniumOut = outfold) |>
        import(ref = "Gene Expression")
})

#> class: SpatialExperiment
#> dim: 5006 36
#> metadata(2): experiment.xenium polygons
#> assays(1): counts
#> rownames(5006): ENSMUSG00000052595 ENSMUSG00000030111 ...
#>   ENSMUSG00000055670 ENSMUSG00000027596
#> rowData names(3): ID Symbol Type
#> colnames(36): aaamobki-1 aaclkaod-1 ... olbjkpjc-1 omjmdimk-1
#> colData names(13): cell_id transcript_counts ... segmentation_method
#>   sample_id
#> reducedDimNames(0):
#> mainExpName: Gene Expression
#> altExpNames(5): Deprecated Codeword Genomic Control Negative Control
#>   Codeword Negative Control Probe Unassigned Codeword
#> spatialCoords names(2) : x_centroid y_centroid
#> imgData names(0):
