import gleam/int
import gleam/list
import gleam/string
import gleam/bool

pub type Error {
  OutOfRange
}

pub fn say(number: Int) -> Result(String, Error) {
  use <- bool.guard(number < 0 || number > 999_999_999_999, Error(OutOfRange))
  use <- bool.guard(number == 0, Ok("zero"))

  number
  |> group_by_thousands()
  |> list.map(translate_group)
  |> string.join(" ")
  |> Ok()
}

fn group_by_thousands(number: Int) -> List(#(String, Int)) {
  let assert Ok(ns) = int.digits(number, 1000)

  list.zip(thousands, list.reverse(ns))
  |> list.filter(fn(p) { p.1 > 0 })
  |> list.reverse()
}

fn translate_group(segment: #(String, Int)) -> String {
  let #(group, n) = segment
  case n / 100, n % 100 {
    0, rem if rem < 100 -> translate_two_digits(rem)
    div, 0 -> get_word(div) <> " hundred"
    div, rem -> get_word(div) <> " hundred " <> translate_two_digits(rem)
  } <> group
}

fn translate_two_digits(n: Int) -> String {
  case n {
    n if n <= 12 -> get_word(n)
    n if n <= 19 -> get_word(n - 10) <> "teen"
    n if n <= 99 ->
      case n % 10 {
        0 -> get_word(n)
        rem -> get_word(n - rem) <> "-" <> get_word(rem)
      }
  }
}

const thousands = ["", " thousand", " million", " billion"]

fn get_word(number: Int) -> String {
  case number {
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    10 -> "ten"
    11 -> "eleven"
    12 -> "twelve"
    20 -> "twenty"
    30 -> "thirty"
    40 -> "forty"
    50 -> "fifty"
    60 -> "sixty"
    70 -> "seventy"
    80 -> "eighty"
    90 -> "ninety"
  }
}
