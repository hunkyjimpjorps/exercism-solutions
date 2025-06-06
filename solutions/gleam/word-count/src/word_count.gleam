import gleam/map.{Map}
import gleam/regex
import gleam/list
import gleam/io
import gleam/string
import gleam/option

pub fn count_words(input: String) -> Map(String, Int) {
  let assert Ok(delimiters) = regex.from_string("[\\s,]")
  regex.split(delimiters, input)
  |> list.filter_map(fn(s) {sanitize_word(s)})
  |> list.sort(string.compare)
  |> list.chunk(fn(x) {x})
  |> list.map(fn(strs) {
      let assert [h, ..] = strs
      #(h, list.length(strs))})
  |> map.from_list()
}

fn sanitize_word(input: String) -> Result(String, String) {
  let assert Ok(sanitizer) = regex.from_string("[^a-z0-9]*([a-z0-9]*'?[a-z0-9]+)[^a-z0-9]*")
  case input {
    "" -> Error("")
    s -> { 
      s 
      |> string.lowercase() 
      |> regex.scan(sanitizer, _) 
      |> extract_submatch() 
      |> Ok()
    }
  }
}

fn extract_submatch(input: List(regex.Match)) -> String {
  let [regex.Match(submatches: [option.Some(w)], ..), ..] = input
  w
}