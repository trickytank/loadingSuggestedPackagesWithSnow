#' Load packages from within a snow instance test
#'
#' @examples
#' cluster <- snow::makeCluster(1)
#' run_in_snow(cluster)
#' @export
run_in_snow <- function(cluster) {
  if (!requireNamespace("dplyr", quietly = TRUE))
    stop("The package 'dplyr' is required to run this function.")
  snow::clusterEvalQ(cluster, {
    require("dplyr")
  })
  starwars_list <- list(slice_sample(starwars, n = 2), slice_sample(starwars, n = 3))
  snow::clusterExport(cluster, c("another_function"))
  snow::parLapply(cluster, starwars_list, simple_function)
}

simple_function <- function(x) {
  another_function(x)
}

another_function <- function(x) {
  mutate(x, height_feet = 0.393701 * height)
}
