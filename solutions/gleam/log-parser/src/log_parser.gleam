import gleam/regexp.{Match}
import gleam/option.{Some}

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(valid_prefix) =
    regexp.from_string("^\\[(WARNING|ERROR|INFO|DEBUG)\\]")
  regexp.check(line, with: valid_prefix)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(arrows) = regexp.from_string("<[~*=-]*>")
  regexp.split(line, with: arrows)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(find_username) = regexp.from_string("User\\s+(\\S*)")
  case regexp.scan(line, with: find_username) {
    [Match(submatches: [Some(s)], ..)] -> "[USER] " <> s <> " " <> line
    _ -> line
  }
}
