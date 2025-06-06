import gleam/regex
import gleam/result.{try}
import gleam/string

pub fn clean(input: String) -> Result(String, String) {
  input
  |> remove_valid_symbols()
  |> try(is_valid_length(_))
  |> try(contains_no_letters(_))
  |> try(contains_no_other_symbols(_))
  |> try(area_code_is_valid(_))
  |> try(exchange_code_is_valid(_))
}

fn remove_valid_symbols(input: String) -> Result(String, String) {
  let assert Ok(re) = regex.from_string("[+\\(\\)\\-\\.\\s]*")

  input
  |> regex.split(with: re)
  |> string.concat()
  |> Ok()
}

fn is_valid_length(input: String) -> Result(String, String) {
  case string.length(input), input {
    n, _ if n < 10 -> Error("must not be fewer than 10 digits")
    11, "1" <> rest -> Ok(rest)
    11, _ -> Error("11 digits must start with 1")
    n, _ if n > 11 -> Error("must not be greater than 11 digits")
    _, _ -> Ok(input)
  }
}

fn contains_no_letters(input: String) -> Result(String, String) {
  let assert Ok(re) = regex.from_string("[a-zA-Z]")

  case regex.check(input, with: re) {
    True -> Error("letters not permitted")
    False -> Ok(input)
  }
}

fn contains_no_other_symbols(input: String) -> Result(String, String) {
  let assert Ok(re) = regex.from_string("[^\\d]")

  case regex.check(input, with: re) {
    True -> Error("punctuations not permitted")
    False -> Ok(input)
  }
}

fn area_code_is_valid(input: String) -> Result(String, String) {
  case string.slice(from: input, at_index: 0, length: 1) {
    "0" -> Error("area code cannot start with zero")
    "1" -> Error("area code cannot start with one")
    _ -> Ok(input)
  }
}

fn exchange_code_is_valid(input: String) -> Result(String, String) {
  case string.slice(from: input, at_index: 3, length: 1) {
    "0" -> Error("exchange code cannot start with zero")
    "1" -> Error("exchange code cannot start with one")
    _ -> Ok(input)
  }
}
