import gleam/regex
import gleam/string
import gleam/set

pub fn is_pangram(sentence: String) -> Bool {
  let assert Ok(alpha) = regex.from_string("[a-z]")

  sentence
  |> string.lowercase()
  |> regex.scan(with: alpha)
  |> set.from_list()
  |> set.size == 26
}
