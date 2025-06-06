import gleam/int
import gleam/list
import gleam/option.{None, Some}
import gleam/regex.{Match}
import gleam/string

pub fn encode(plaintext: String) -> String {
  let assert Ok(re) = regex.from_string("(.)\\1*")
  regex.scan(with: re, content: plaintext)
  |> list.map(full_to_encoded)
  |> string.concat()
}

pub fn decode(ciphertext: String) -> String {
  let assert Ok(re) = regex.from_string("([0-9]*)([A-Za-z\\s])")
  regex.scan(with: re, content: ciphertext)
  |> list.map(encoded_to_full)
  |> string.concat()
}

fn full_to_encoded(m: Match) -> String {
  let Match(full, [Some(char)]) = m
  case string.length(full) {
    1 -> char
    n -> int.to_string(n) <> char
  }
}

fn encoded_to_full(m: Match) -> String {
  case m {
    Match(_, [None, Some(c)]) -> c
    Match(_, [Some(n_str), Some(c)]) -> {
      let assert Ok(n) = int.parse(n_str)
      string.repeat(c, n)
    }
  }
}
