import gleam/result
import gleam/list
import gleam/string
import gleam/bool

pub type Error {
  KeyNotCoprime(Int, Int)
}

type CharacterType {
  Letter
  Number
  Other
}

const alphabet = "abcdefghijklmnopqrstuvwxyz"

const numbers = "0123456789"

const m = 26

const a_codepoint = 97

pub fn encode(
  plaintext plaintext: String,
  a a: Int,
  b b: Int,
) -> Result(String, Error) {
  use <- bool.guard(egcd(a, m).0 != 1, Error(KeyNotCoprime(a, m)))
  plaintext
  |> string.to_graphemes()
  |> list.filter_map(fn(c) {
    case character_type(c) {
      Other -> Error(Nil)
      Number -> Ok(c)
      Letter -> Ok(transform(c, fn(i) { mod(a * i + b, m) }))
    }
  })
  |> list.sized_chunk(5)
  |> list.map(string.concat)
  |> string.join(" ")
  |> Ok()
}

pub fn decode(
  ciphertext ciphertext: String,
  a a: Int,
  b b: Int,
) -> Result(String, Error) {
  let #(g, mmi, _) = egcd(a, m)
  use <- bool.guard(g != 1, Error(KeyNotCoprime(a, m)))
  ciphertext
  |> string.to_graphemes()
  |> list.filter_map(fn(c) {
    case character_type(c) {
      Other -> Error(Nil)
      Number -> Ok(c)
      Letter -> Ok(transform(c, fn(i) { mod(mmi * { i - b }, m) }))
    }
  })
  |> string.concat()
  |> Ok()
}

fn egcd(a: Int, b: Int) -> #(Int, Int, Int) {
  case a {
    0 -> #(b, 0, 1)
    _ -> {
      let #(g, x, y) = egcd(b % a, a)
      #(g, y - b / a * x, x)
    }
  }
}

fn mod(a: Int, b: Int) -> Int {
  { a % b + b } % b
}

fn to_index(c: String) -> Int {
  let [codepoint] = string.to_utf_codepoints(string.lowercase(c))
  string.utf_codepoint_to_int(codepoint) - a_codepoint
}

fn to_char(i: Int) -> String {
  [string.utf_codepoint(i + a_codepoint)]
  |> result.values()
  |> string.from_utf_codepoints()
}

fn transform(c: String, f: fn(Int) -> Int) -> String {
  c
  |> to_index
  |> f
  |> to_char
}

fn character_type(c: String) -> CharacterType {
  use <- bool.guard(string.contains(alphabet, string.lowercase(c)), Letter)
  use <- bool.guard(string.contains(numbers, c), Number)
  Other
}
