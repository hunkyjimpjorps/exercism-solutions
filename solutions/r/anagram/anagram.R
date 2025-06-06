library(purrr)
library(stringr)

normalize <- function(word) {
  word %>%
    str_to_lower() %>%
    str_split_1("") %>%
    sort()
}

is_anagram <- function(word1, word2) {
  str_length(word1) == str_length(word2) &&
    str_to_lower(word1) != str_to_lower(word2) &&
    all(normalize(word1) == normalize(word2))
}

anagram <- function(subject, candidates) {
  candidates %>%
    keep(\(w) is_anagram(w, subject)) %>%
    `if`((length(.) == 0L), NULL, .)
}
