hamming <- function(strand1, strand2) {
  stopifnot(nchar(strand1) == nchar(strand2))
  (charToRaw(strand1) != charToRaw(strand2)) |> sum()
}
