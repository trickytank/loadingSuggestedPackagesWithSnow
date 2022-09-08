#' Load packages from within a snow instance test using require
#'
#' @param cluster A cluster object from snow.
#' @examples
#' cluster_req <- snow::makeCluster(1)
#' run_in_snow_require(cluster_req)
#' @export
run_in_snow_require <- function(cluster) {
  if (!requireNamespace("S4Vectors", quietly = TRUE))
    stop("The package 'S4Vectors' is required to run this function.")
  snow::clusterEvalQ(cluster, {
    require("S4Vectors")
  })
  starwars_list <- list(dplyr::slice_sample(starwars, n = 2), dplyr::slice_sample(starwars, n = 3))
  snow::clusterExport(cluster, c("another_function"))
  snow::parLapply(cluster, starwars_list, simple_function)
}

#' Load packages from within a snow instance test using requireNamespace
#'
#' @param cluster A cluster object from snow.
#' @examples
#' cluster_rns <- snow::makeCluster(1)
#' run_in_snow_requireNamespace(cluster_rns)
#' @export
run_in_snow_requireNamespace <- function(cluster) {
  if (!requireNamespace("S4Vectors", quietly = TRUE))
    stop("The package 'S4Vectors' is required to run this function.")
  my_list <- list(array(1:4, c(2,1,2)), array(3:5, c(2,1)))
  snow::clusterExport(cluster, c("another_function"))
  snow::parLapply(cluster, my_list, simple_function)
}

simple_function <- function(x) {
  another_function(x)
}

another_function <- function(x) {
  DataFrameX <- S4Vectors::DataFrame
  sw <- do.call("DataFrameX", list(x))
}
