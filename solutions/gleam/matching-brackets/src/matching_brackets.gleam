import gleam/string

type BracketType {
  Opening(String)
  Closing(String)
  NotABracket
}

pub fn is_paired(value: String) -> Bool {
  check_next_char(value, [])
}

fn bracket_type(char: String) -> BracketType {
  case char {
    "(" | "[" | "{" -> Opening(char)
    ")" | "]" | "}" -> Closing(char)
    _ -> NotABracket
  }
}

fn matching_brackets(char1: String, char2: String) -> Bool {
  case char1, char2 {
    "(", ")" | "[", "]" | "{", "}" -> True
    _, _ -> False
  }
}

fn check_next_char(str: String, stack: List(String)) -> Bool {
  case string.pop_grapheme(str), stack {
    Ok(#(h, t)), _ ->
      case bracket_type(h), stack {
        NotABracket, _ -> check_next_char(t, stack)
        Opening(c), _ -> check_next_char(t, [c, ..stack])
        Closing(_), [] -> False
        Closing(c), [stack_h, ..stack_t] ->
          case matching_brackets(stack_h, c) {
            True -> check_next_char(t, stack_t)
            False -> False
          }
        _, _ -> False
      }
    Error(Nil), [] -> True
    Error(Nil), _ -> False
  }
}
