#' Load packages from within a snow instance test
#'
#' @examples
#' cluster <- snow::makeCluster(1)
#' run_in_snow(cluster)
#' @import snow
#' @export
run_in_snow <- function(cluster) {
  if (!requireNamespace("dplyr", quietly = TRUE))
    stop("The package 'dplyr' is required to run this function.")
  snow::clusterEvalQ(cluster, {
    require("dplyr")
  })

}
