import gleam/dict.{type Dict}
import gleam/regexp
import gleam/list
import gleam/option
import gleam/string

pub fn count_words(input: String) -> Dict(String, Int) {
  let assert Ok(delimiters) = regexp.from_string("[\\s,]")
  regexp.split(delimiters, input)
  |> list.filter_map(fn(s) {sanitize_word(s)})
  |> list.sort(string.compare)
  |> list.chunk(fn(x) {x})
  |> list.map(fn(strs) {
      let assert [h, ..] = strs
      #(h, list.length(strs))})
  |> dict.from_list()
}

fn sanitize_word(input: String) -> Result(String, String) {
  let assert Ok(sanitizer) = regexp.from_string("[^a-z0-9]*([a-z0-9]*'?[a-z0-9]+)[^a-z0-9]*")
  case input {
    "" -> Error("")
    s -> { 
      s 
      |> string.lowercase() 
      |> regexp.scan(sanitizer, _) 
      |> extract_submatch() 
      |> Ok()
    }
  }
}

fn extract_submatch(input: List(regexp.Match)) -> String {
  let assert [regexp.Match(submatches: [option.Some(w)], ..), ..] = input
  w
}