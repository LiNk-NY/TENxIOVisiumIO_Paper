reprex::reprex({
   suppressPackageStartupMessages(library(TENxIO))
    tarfile <- system.file(
        "extdata",
        "pbmc_granulocyte_sorted_3k_ff_bc_ex_matrix.tar.gz",
        package = "TENxIO",
        mustWork = TRUE
    )
    (txfl <- TENxFileList(tarfile))
    import(txfl)
}, venue = "r")

#> class: SingleCellExperiment
#> dim: 10 10
#> metadata(1): TENxFileList
#> assays(1): counts
#> rownames(10): ENSG00000243485 ENSG00000237613 ... ENSG00000286448
#>   ENSG00000236601
#> rowData names(3): ID Symbol Type
#> colnames(10): AAACAGCCAAATATCC-1 AAACAGCCAGGAACTG-1 ...
#>   AAACCGCGTGAGGTAG-1 AAACGCGCATACCCGG-1
#> colData names(0):
#> reducedDimNames(0):
#> mainExpName: Gene Expression
#> altExpNames(0):
