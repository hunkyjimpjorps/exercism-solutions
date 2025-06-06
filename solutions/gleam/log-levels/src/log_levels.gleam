import gleam/regexp
import gleam/option
import gleam/string

fn re() {
  let assert Ok(re) = regexp.from_string("\\[(.*)\\]:\\s*(.*)\\s*")
  re
}

pub fn message(log_line: String) -> String {
  let assert [result] = regexp.scan(with: re(), content: log_line)
  let assert [_, message] = result.submatches
  option.unwrap(message, "") |> string.trim()
}

pub fn log_level(log_line: String) -> String {
  let assert [result] = regexp.scan(with: re(), content: log_line)
  let assert [level, _] = result.submatches
  option.unwrap(level, "") |> string.lowercase()
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
