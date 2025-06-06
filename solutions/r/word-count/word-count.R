library(purrr)
library(stringr)

list_upsert <- function(lst, k, f, v0) {
  if (is.null(lst[[k]])) {
    lst[[k]] <- v0
  } else {
    lst[[k]] <- f(lst[[k]])
  }
  lst
}

add_1 <- function(n) {
  n + 1
}

tally <- function(lst, word) {
  list_upsert(lst, word, add_1, 1)
}

word_count <- function(input) {
  input %>%
    str_to_lower() %>%
    str_split_1("[^a-z0-9']+") %>%
    str_replace_all("^'?(.*?)'?$", "\\1") %>%
    discard(\(w) w == "") %>%
    reduce(tally, .init = list())
}
