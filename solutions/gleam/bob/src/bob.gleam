import gleam/regexp
import gleam/string

type Volume {
  Silent
  Aloud
}

type Intensity {
  Spoken
  Yelled
}

type Interrogating {
  Asked
  Stated
}

fn contains_letters(remark: String) -> Bool {
  let assert Ok(re) = regexp.from_string("[A-Za-z]")
  regexp.check(with: re, content: remark)
}

fn is_yelling(remark: String) -> Intensity {
  case contains_letters(remark) && { string.uppercase(remark) == remark } {
    True -> Yelled
    False -> Spoken
  }
}

fn is_a_question(remark: String) -> Interrogating {
  case
    remark
    |> string.trim()
    |> string.ends_with("?")
  {
    True -> Asked
    False -> Stated
  }
}

fn is_silent(remark: String) -> Volume {
  case string.trim(remark) {
    "" -> Silent
    _ -> Aloud
  }
}

pub fn hey(remark: String) -> String {
  case is_silent(remark), is_yelling(remark), is_a_question(remark) {
    Silent, _, _ -> "Fine. Be that way!"
    _, Yelled, Asked -> "Calm down, I know what I'm doing!"
    _, Yelled, Stated -> "Whoa, chill out!"
    _, Spoken, Asked -> "Sure."
    _, _, _ -> "Whatever."
  }
}
