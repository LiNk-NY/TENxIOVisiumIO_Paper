reprex::reprex({
   suppressPackageStartupMessages(library(TENxIO))
    tarfile <- system.file(
        "extdata", "pbmc_granulocyte_sorted_3k_ff_bc_ex_matrix.tar.gz",
        package = "TENxIO", mustWork = TRUE
    )
    TENxFileList(tarfile)
    import(TENxFileList(tarfile))
}, venue = "r")


library(TENxIO)
tarfile <- system.file(
    "extdata",
    "pbmc_granulocyte_sorted_3k_ff_bc_ex_matrix.tar.gz",
    package = "TENxIO",
    mustWork = TRUE
)
(txfl <- TENxFileList(tarfile))
#> TENxFileList of length 1
import(txfl)
#> class: SingleCellExperiment
#> dim: 10 10
#> metadata(0):
#> assays(1): counts
#> rownames: NULL
#> rowData names(3): ID Symbol Type
#> colnames(10): AAACAGCCAAATATCC-1 AAACAGCCAGGAACTG-1 ...
#>   AAACCGCGTGAGGTAG-1 AAACGCGCATACCCGG-1
#> colData names(0):
#> reducedDimNames(0):
#> mainExpName: Gene Expression
#> altExpNames(0):
