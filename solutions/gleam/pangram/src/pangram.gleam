import gleam/regex
import gleam/list
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  let assert Ok(nonalpha) = regex.from_string("[^a-z]")

  sentence
  |> string.lowercase()
  |> regex.split(with: nonalpha)
  |> string.concat()
  |> string.to_graphemes()
  |> list.unique()
  |> list.length()
  |> { fn(n) { n == 26 } }
}
