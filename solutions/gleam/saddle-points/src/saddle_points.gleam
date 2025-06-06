import gleam/list
import gleam/int
import gleam/result

pub type Position {
  Position(row: Int, column: Int)
}

pub fn saddle_points(rows: List(List(Int))) -> List(Position) {
  {
    use r, row <- list.index_map(rows)
    use c, col <- list.index_map(list.transpose(rows))
    case list.reduce(row, int.max) == list.reduce(col, int.min) {
      True -> Ok(Position(r + 1, c + 1))
      False -> Error(Nil)
    }
  }
  |> list.flatten()
  |> result.values()
}
