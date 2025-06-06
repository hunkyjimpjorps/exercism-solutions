import gleam/list
import gleam/string
import gleam/map.{Map}
import gleam/io
import gleam/result
import gleam/function

pub type Points =
  Map(#(Int, Int), Content)

pub type Content {
  Corner
  HorizontalLine
  VerticalLine
  Nothing
}

pub fn rectangles(input: String) -> Int {
  let points =
    input
    |> clean_input()
    |> input_to_array()

  let corners = map.filter(points, fn(_, v) { v == Corner })

  corners
  |> map.keys()
  |> list.combination_pairs()
  |> list.filter(fn(tups) {
    let #(#(i1, j1), #(i2, j2)) = tups
    i1 < i2 && j1 < j2 && all_connected(tups, points)
  })
  |> list.length()
}

fn clean_input(input: String) -> List(String) {
  input
  |> string.trim()
  |> string.split("\n")
  |> list.map(string.trim)
}

fn input_to_array(input: List(String)) -> Points {
  input
  |> list.index_map(fn(i, r) {
    r
    |> string.to_graphemes()
    |> list.index_map(fn(j, c) { #(#(i, j), to_content(c)) })
  })
  |> list.concat()
  |> map.from_list()
}

fn to_content(c: String) -> Content {
  case c {
    " " -> Nothing
    "-" -> HorizontalLine
    "|" -> VerticalLine
    "+" -> Corner
  }
}

fn all_connected(tups: #(#(Int, Int), #(Int, Int)), points: Points) -> Bool {
  let #(#(i1, j1), #(i2, j2)) = tups
  list.all(
    list.range(i1, i2),
    fn(i) {
      case map.get(points, #(i, j1)) {
        Ok(VerticalLine) | Ok(Corner) -> True
        _ -> False
      }
    },
  ) && list.all(
    list.range(i1, i2),
    fn(i) {
      case map.get(points, #(i, j2)) {
        Ok(VerticalLine) | Ok(Corner) -> True
        _ -> False
      }
    },
  ) && list.all(
    list.range(j1, j2),
    fn(j) {
      case map.get(points, #(i1, j)) {
        Ok(HorizontalLine) | Ok(Corner) -> True
        _ -> False
      }
    },
  ) && list.all(
    list.range(j1, j2),
    fn(j) {
      case map.get(points, #(i2, j)) {
        Ok(HorizontalLine) | Ok(Corner) -> True
        _ -> False
      }
    },
  )
}
