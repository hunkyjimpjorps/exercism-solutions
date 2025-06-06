import gleam/map.{Map}
import gleam/list
import gleam/string

pub fn transform(legacy: Map(Int, List(String))) -> Map(String, Int) {
  legacy
  |> map.to_list()
  |> list.flat_map(fn(p) {
    let #(score, letters) = p
    list.map(letters, fn(l) { #(string.lowercase(l), score) })
  })
  |> map.from_list()
}
