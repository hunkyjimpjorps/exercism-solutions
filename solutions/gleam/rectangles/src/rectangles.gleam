import gleam/list
import gleam/string
import gleam/map.{Map}

pub type Points =
  Map(#(Int, Int), String)

pub fn rectangles(input: String) -> Int {
  let points =
    input
    |> string.split("\n")
    |> input_to_array()

  points
  |> map.filter(fn(_, v) { v == "+" })
  |> map.keys()
  |> list.combination_pairs()
  |> list.filter(fn(corners) {
    let #(#(i1, j1), #(i2, j2)) = corners
    i1 < i2 && j1 < j2 && all_connected(corners, points)
  })
  |> list.length()
}

fn input_to_array(input: List(String)) -> Points {
  input
  |> list.index_map(fn(i, r) {
    r
    |> string.to_graphemes()
    |> list.index_map(fn(j, c) { #(#(i, j), c) })
  })
  |> list.concat()
  |> map.from_list()
}

fn all_connected(corners: #(#(Int, Int), #(Int, Int)), points: Points) -> Bool {
  let #(#(i1, j1), #(i2, j2)) = corners
  list.all(
    list.range(i1, i2),
    fn(i) {
      case map.get(points, #(i, j1)) {
        Ok("|") | Ok("+") -> True
        _ -> False
      } && case map.get(points, #(i, j2)) {
        Ok("|") | Ok("+") -> True
        _ -> False
      }
    },
  ) && list.all(
    list.range(j1, j2),
    fn(j) {
      case map.get(points, #(i1, j)) {
        Ok("-") | Ok("+") -> True
        _ -> False
      } && case map.get(points, #(i2, j)) {
        Ok("-") | Ok("+") -> True
        _ -> False
      }
    },
  )
}