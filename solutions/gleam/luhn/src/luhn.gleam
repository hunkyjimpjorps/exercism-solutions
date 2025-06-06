import gleam/list
import gleam/int
import gleam/regex
import gleam/result.{map, try}
import gleam/string

pub fn valid(value: String) -> Bool {
  Ok(value)
  |> map(string.replace(_, " ", ""))
  |> try(is_valid_length(_))
  |> try(doesnt_contain_invalid_symbols(_))
  |> try(has_valid_luhn_sum(_))
  |> result.is_ok()
}

fn is_valid_length(value: String) -> Result(String, Nil) {
  case string.length(value) {
    0 | 1 -> Error(Nil)
    _ -> Ok(value)
  }
}

fn doesnt_contain_invalid_symbols(value: String) -> Result(String, Nil) {
  let assert Ok(re) = regex.from_string("[^0-9]")
  case regex.check(re, value) {
    True -> Error(Nil)
    False -> Ok(value)
  }
}

fn has_valid_luhn_sum(value: String) -> Result(String, Nil) {
  let sum =
    value
    |> string.to_graphemes()
    |> list.reverse()
    |> list.index_map(fn(i, n_str) {
      let assert Ok(n) = int.parse(n_str)
      case i % 2, 2 * n {
        0, _ -> n
        1, d if d > 9 -> d - 9
        1, d -> d
      }
    })
    |> int.sum()

  case sum % 10 {
    0 -> Ok(value)
    _ -> Error(Nil)
  }
}
