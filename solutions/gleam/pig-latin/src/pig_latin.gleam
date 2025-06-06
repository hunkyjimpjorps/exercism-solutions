import gleam/string
import gleam/list
import gleam/regex.{Match}
import gleam/option.{Some}

type Status {
  Untranslated(String)
  Translated(String)
}

pub fn translate(phrase: String) -> String {
  phrase
  |> string.split(" ")
  |> list.map(translate_word)
  |> string.join(" ")
}

fn translate_word(word: String) -> String {
  Untranslated(word)
  |> apply(vowel_sound_rule)
  |> apply(consonant_sound_rule)
  |> unwrap()
}

fn apply(word: Status, f: fn(String) -> Status) -> Status {
  case word {
    Untranslated(w) -> f(w)
    Translated(_) -> word
  }
}

fn unwrap(word: Status) -> String {
  let assert Translated(w) = word
  w
}

fn vowel_sound_rule(word: String) -> Status {
  let assert Ok(re) = regex.from_string("^([aeoiu]|xr|yt)(.*)$")
  case regex.scan(re, word) {
    [] -> Untranslated(word)
    [Match(submatches: [Some(_), Some(_)], ..)] -> Translated(word <> "ay")
  }
}

fn consonant_sound_rule(word: String) -> Status {
  let assert Ok(re) = regex.from_string("^(thr|sch|squ|sh|ch|th|qu|rh|.)(.*)$")
  case regex.scan(re, word) {
    [] -> Untranslated(word)
    [Match(submatches: [Some(prefix), Some(suffix)], ..)] ->
      Translated(suffix <> prefix <> "ay")
  }
}
