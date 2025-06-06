library(purrr)
library(stringr)

# Determine whether the number is valid.
is_valid <- function(input) {
  input <- str_replace_all(input, " ", "")

  if (str_length(input) <= 1 || !str_detect(input, "^[0-9]*$")) {
    return(FALSE)
  }

  input %>%
    str_split_1("") %>%
    map(as.numeric) %>%
    rev() %>%
    imap(\(x, idx) if (idx %% 2 == 0) (2 * x) else x) %>%
    reduce(\(acc, x) if (x > 9) acc + x - 9 else acc + x) %>%
    (\(n) n %% 10 == 0)()
}
