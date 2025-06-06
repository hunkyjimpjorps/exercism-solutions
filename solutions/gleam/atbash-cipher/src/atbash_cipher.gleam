import gleam/string
import gleam/list
import gleam/map

const alphabet = "abcdefghijklmnopqrstuvwxyz"

const digits = "0123456789"

pub fn encode(phrase: String) -> String {
  phrase
  |> transform_to_graphemes()
  |> list.sized_chunk(5)
  |> list.map(string.concat)
  |> string.join(" ")
}

pub fn decode(phrase: String) -> String {
  phrase
  |> transform_to_graphemes()
  |> string.concat()
}

fn transform_to_graphemes(phrase: String) -> List(String) {
  let alpha_graphemes = string.to_graphemes(alphabet)
  let digit_graphemes = string.to_graphemes(digits)
  let dict =
    list.zip(
      list.append(alpha_graphemes, digit_graphemes),
      list.append(list.reverse(alpha_graphemes), digit_graphemes),
    )
    |> map.from_list()

  phrase
  |> string.lowercase()
  |> string.to_graphemes()
  |> list.filter_map(map.get(dict, _))
}
