import gleam/option.{type Option}

pub fn two_fer(name: Option(String)) -> String {
  "One for " <> option.unwrap(name, or: "you") <> ", one for me."
}
