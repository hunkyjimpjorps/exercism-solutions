import gleam/regex
import gleam/string
import gleam/result
import gleam/int
import gleam/list

pub fn is_valid(isbn: String) -> Bool {
  Ok(isbn)
  |> result.try(clean_isbn)
  |> result.try(is_valid_format)
  |> result.try(has_valid_checksum)
  |> result.is_ok
}

fn clean_isbn(isbn: String) -> Result(String, Nil) {
  Ok(string.replace(isbn, each: "-", with: ""))
}

fn is_valid_format(isbn: String) -> Result(String, Nil) {
  let assert Ok(re) = regex.from_string("^[0-9]{9}[0-9X]$")
  case regex.check(isbn, with: re) {
    True -> Ok(isbn)
    False -> Error(Nil)
  }
}

fn has_valid_checksum(isbn: String) -> Result(String, Nil) {
  let sum =
    isbn
    |> string.to_graphemes()
    |> list.map2(list.range(10, 1), fn(d, n) { to_value(d) * n })
    |> int.sum()
  case sum % 11 == 0 {
    True -> Ok(isbn)
    False -> Error(Nil)
  }
}

fn to_value(digit: String) -> Int {
  int.parse(digit)
  |> result.unwrap(10)
}
