import gleam/regexp
import gleam/string
import gleam/list
import gleam/set

pub fn is_isogram(phrase phrase: String) -> Bool {
  let assert Ok(re) = regexp.from_string("[a-z]*")
  let matches = regexp.scan(with: re, content: string.lowercase(phrase)) 
    |> list.map(fn(m) {m.content}) 
    |> string.concat()
    |> string.to_graphemes()
  list.length(matches) == set.size(set.from_list(matches))
}
