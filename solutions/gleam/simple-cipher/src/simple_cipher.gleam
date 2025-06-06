import gleam/int
import gleam/list
import gleam/iterator
import gleam/string

pub fn encode(plaintext plaintext: String, key key: String) -> String {
  transform(plaintext, key, fn(char, shift) { shift_character(char, shift) })
}

pub fn decode(ciphertext ciphertext: String, key key: String) -> String {
  transform(ciphertext, key, fn(char, shift) { shift_character(char, -shift) })
}

fn transform(
  text: String,
  key: String,
  transformation: fn(String, Int) -> String,
) -> String {
  text
  |> string.to_graphemes()
  |> iterator.from_list()
  |> iterator.zip(calculate_key(key))
  |> iterator.map(fn(p) {
    let #(char, shift) = p
    transformation(char, shift)
  })
  |> iterator.to_list()
  |> string.concat()
}

pub fn generate_key() -> String {
  iterator.repeatedly(fn() {
    let assert Ok(c) = string.utf_codepoint(int.random(97, 122))
    c
  })
  |> iterator.take(100)
  |> iterator.to_list()
  |> string.from_utf_codepoints()
}

fn calculate_key(key: String) -> iterator.Iterator(Int) {
  key
  |> string.to_utf_codepoints()
  |> list.map(fn(codepoint) { string.utf_codepoint_to_int(codepoint) - 97 })
  |> iterator.from_list()
  |> iterator.cycle()
}

fn shift_character(char: String, shift: Int) -> String {
  let [codepoint] =
    char
    |> string.to_utf_codepoints()
  let shifted = case string.utf_codepoint_to_int(codepoint) + shift {
    i if i < 97 -> i + 26
    i if i > 122 -> i - 26
    i -> i
  }
  let assert Ok(shifted_codepoint) = string.utf_codepoint(shifted)
  string.from_utf_codepoints([shifted_codepoint])
}
