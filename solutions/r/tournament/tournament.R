library(dplyr)
library(purrr)
library(stringr)
library(tibble)

won_game <- function(results, winner, loser) {
  results %>%
    add_row(Team = winner, MP = 1, W = 1, D = 0) %>%
    add_row(Team = loser, MP = 1, W = 0, D = 0)
}

draw_game <- function(results, team1, team2) {
  results %>%
    add_row(Team = team1, MP = 1, W = 0, D = 1) %>%
    add_row(Team = team2, MP = 1, W = 0, D = 1)
}

update_results <- function(results, match) {
  parsed_match <- str_split_1(match, ";")
  if (length(parsed_match) != 3) {
    return(results)
  }
  switch(parsed_match[3],
    "win" = won_game(results, parsed_match[1], parsed_match[2]),
    "loss" = won_game(results, parsed_match[2], parsed_match[1]),
    "draw" = draw_game(results, parsed_match[1], parsed_match[2]),
    results
  )
}

tournament <- function(input) {
  results <-
    tibble(Team = character(), MP = numeric(), W = numeric(), D = numeric())

  reduce(input, update_results, .init = results) %>%
    group_by(Team) %>%
    summarize(MP = sum(MP), W = sum(W), D = sum(D)) %>%
    mutate(L = MP - W - D, P = 3 * W + D) %>%
    arrange(desc(P), Team) %>%
    as.data.frame()
}
