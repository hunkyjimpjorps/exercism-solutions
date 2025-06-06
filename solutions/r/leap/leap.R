div <- function(a, b) a %% b == 0

leap <- function(year) {
  div(year, 4) && (!div(year, 100) || div(year, 400))
}
