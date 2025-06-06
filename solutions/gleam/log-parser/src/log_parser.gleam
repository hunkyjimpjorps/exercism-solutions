import gleam/regex.{Match}
import gleam/option.{Some}

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(valid_prefix) =
    regex.from_string("^\\[(WARNING|ERROR|INFO|DEBUG)\\]")
  regex.check(line, with: valid_prefix)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(arrows) = regex.from_string("<[~*=-]*>")
  regex.split(line, with: arrows)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(find_username) = regex.from_string("User\\s+(\\S*)")
  case regex.scan(line, with: find_username) {
    [Match(submatches: [Some(s)], ..)] -> "[USER] " <> s <> " " <> line
    [] -> line
  }
}
