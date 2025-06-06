library(purrr)

collatz_step_counter <- function(num) {
  map_vec(num, collatz)
}

collatz <- function(num) {
  if (num < 1) {
    stop()
  } else if (num == 1) {
    0
  } else if (num %% 2 == 0) {
    1 + collatz(num / 2)
  } else {
    1 + collatz(3 * num + 1)
  }
}
