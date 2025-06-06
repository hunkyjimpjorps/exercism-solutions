score <- function(x, y) {
  dist <- sqrt(x^2 + y^2)

  if (dist <= 1) {
    10
  } else if (dist <= 5) {
    5
  } else if (dist <= 10) {
    1
  } else {
    0
  }
}
