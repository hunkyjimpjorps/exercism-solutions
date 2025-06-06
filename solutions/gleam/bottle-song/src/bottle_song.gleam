import gleam/string
import gleam/list

pub fn recite(
  start_bottles start_bottles: Int,
  take_down take_down: Int,
) -> String {
  list.range(start_bottles, start_bottles - take_down + 1)
  |> list.map(verse)
  |> string.join("\n\n")
}

const third = "And if one green bottle should accidentally fall,"

fn verse(n: Int) -> String {
  let first =
    string.capitalise(plural(n, "green bottle")) <> " hanging on the wall,"
  let fourth =
    "There'll be " <> plural(n - 1, "green bottle") <> " hanging on the wall."

  string.join([first, first, third, fourth], "\n")
}

fn get_word(n: Int) -> String {
  case n {
    0 -> "no"
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    10 -> "ten"
  }
}

fn plural(n: Int, word: String) -> String {
  get_word(n) <> " " <> case n {
    1 -> word
    _ -> word <> "s"
  }
}
