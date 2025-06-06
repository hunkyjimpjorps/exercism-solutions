import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  legacy
  |> dict.to_list()
  |> list.flat_map(fn(p) {
    let #(score, letters) = p
    list.map(letters, fn(l) { #(string.lowercase(l), score) })
  })
  |> dict.from_list()
}
