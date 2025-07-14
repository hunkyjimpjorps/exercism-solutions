import gleam/bool
import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/string

type Coordinate =
  #(Int, Int)

type FlowerMap =
  Dict(Coordinate, String)

pub fn annotate(flower_field: String) -> String {
  use <- bool.guard(flower_field == "", "")
  flower_field
  |> input_to_array()
  |> count_flowers()
  |> array_to_output()
}

fn input_to_array(flower_field: String) -> Dict(Coordinate, String) {
  {
    use row, i <- list.index_map(string.split(flower_field, "\n"))
    use col, j <- list.index_map(string.to_graphemes(row))
    #(#(i, j), col)
  }
  |> list.flatten()
  |> dict.from_list()
}

fn count_flowers(flower_map: FlowerMap) -> FlowerMap {
  use k, v <- dict.map_values(flower_map)
  case v {
    "*" -> "*"
    _ ->
      all_neighbors(k)
      |> list.filter(fn(p) { dict.get(flower_map, p) == Ok("*") })
      |> list.length()
      |> fn(n) { bool.guard(n == 0, "_", fn() { int.to_string(n) }) }
  }
}

fn all_neighbors(p: Coordinate) -> List(Coordinate) {
  let #(i, j) = p
  let delta = [-1, 0, 1]
  use n <- list.flat_map(delta)
  use m <- list.filter_map(delta)
  case n, m {
    0, 0 -> Error(Nil)
    _, _ -> Ok(#(i + n, j + m))
  }
}

fn array_to_output(flower_map: FlowerMap) -> String {
  let #(imax, jmax) =
    flower_map
    |> dict.fold(#(0, 0), fn(acc, p, _) {
      case acc.0 + acc.1 < p.0 + p.1 {
        True -> p
        False -> acc
      }
    })

  {
    use row <- list.map(list.range(0, imax))
    use col <- list.map(list.range(0, jmax))
    let assert Ok(s) = dict.get(flower_map, #(row, col))
    s
  }
  |> list.map(string.concat)
  |> string.join("\n")
}
