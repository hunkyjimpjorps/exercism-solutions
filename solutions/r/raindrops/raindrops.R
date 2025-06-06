key <- data.frame(div = c(3, 5, 7), name = c("Pling", "Plang", "Plong"))

raindrops <- function(number) {
  sounds <- ifelse(number %% key$div == 0, key$name, "")
  sound <- paste0(sounds, collapse = "")
  if (sound == "") as.character(number) else sound
}
