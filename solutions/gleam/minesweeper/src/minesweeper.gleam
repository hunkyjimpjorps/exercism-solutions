import gleam/map
import gleam/string
import gleam/list
import gleam/int
import gleam/bool

type Coordinate =
  #(Int, Int)

type MineMap =
  map.Map(Coordinate, String)

pub fn annotate(minefield: String) -> String {
  use <- bool.guard(minefield == "", "")
  minefield
  |> input_to_array()
  |> count_mines()
  |> array_to_output()
}

fn input_to_array(minefield: String) -> map.Map(Coordinate, String) {
  {
    use i, row <- list.index_map(string.split(minefield, "\n"))
    use j, col <- list.index_map(string.to_graphemes(row))
    #(#(i, j), col)
  }
  |> list.flatten()
  |> map.from_list()
}

fn count_mines(minemap: MineMap) -> MineMap {
  use k, v <- map.map_values(minemap)
  case v {
    "*" -> "*"
    _ ->
      all_neighbors(k)
      |> list.filter(fn(p) { map.get(minemap, p) == Ok("*") })
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

fn array_to_output(minemap: MineMap) -> String {
  let #(imax, jmax) =
    map.fold(
      minemap,
      #(0, 0),
      fn(acc, p, _) {
        case acc.0 + acc.1 < p.0 + p.1 {
          True -> p
          False -> acc
        }
      },
    )

  {
    use row <- list.map(list.range(0, imax))
    use col <- list.map(list.range(0, jmax))
    let assert Ok(s) = map.get(minemap, #(row, col))
    s
  }
  |> list.map(string.concat(_))
  |> string.join("\n")
}
