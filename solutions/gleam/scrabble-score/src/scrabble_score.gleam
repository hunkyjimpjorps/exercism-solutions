import gleam/string
import gleam/list

pub fn score(word: String) -> Int {
  word
  |> string.uppercase()
  |> string.to_graphemes()
  |> list.fold(0, fn(acc, c) { acc + score_letter(c) })
}

fn score_letter(letter: String) -> Int {
  case letter {
    "A" | "E" | "I" | "O" | "U" | "L" | "N" | "R" | "S" | "T" -> 1
    "D" | "G" -> 2
    "B" | "C" | "M" | "P" -> 3
    "F" | "H" | "V" | "W" | "Y" -> 4
    "K" -> 5
    "Q" | "Z" -> 10
    "J" | "X" -> 8
  }
}
