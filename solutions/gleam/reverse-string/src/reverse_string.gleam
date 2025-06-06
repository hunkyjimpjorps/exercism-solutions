import gleam/string

pub fn reverse(value: String) -> String {
  case string.pop_grapheme(value) {
    Error(_) -> ""
    Ok(#(h, t)) -> reverse(t) <> h
  }
}
