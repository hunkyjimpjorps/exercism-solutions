import gleam/regex
import gleam/list
import gleam/string

pub fn abbreviate(phrase phrase: String) -> String {
  let assert Ok(re) = regex.from_string("[\\s_-]+")
  phrase
  |> regex.split(with: re)
  |> list.filter_map(fn(str) {
    str
    |> string.capitalise()
    |> string.first()
  })
  |> string.concat()
}
