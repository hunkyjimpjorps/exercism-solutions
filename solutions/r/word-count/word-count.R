library(purrr)
library(stringr)
library(dplyr)
library(tibble)

word_count <- function(input) {
  input |>
    str_to_lower() |>
    str_split_1("[^a-z0-9']+") |>
    str_replace_all("^'?(.*?)'?$", "\\1") |>
    discard(\(w) w == "") |>
    enframe(name = NULL, value = "word") |>
    group_by(word) |>
    count() |>
    deframe() |>
    as.list()
}
