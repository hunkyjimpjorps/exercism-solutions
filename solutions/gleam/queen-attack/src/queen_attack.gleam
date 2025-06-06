import gleam/int

pub type Position {
  Position(row: Int, column: Int)
}

pub type Error {
  RowTooSmall
  RowTooLarge
  ColumnTooSmall
  ColumnTooLarge
}

pub fn create(queen: Position) -> Result(Nil, Error) {
  case queen {
    Position(row: r, ..) if r < 0 -> Error(RowTooSmall)
    Position(row: r, ..) if r > 7 -> Error(RowTooLarge)
    Position(column: c, ..) if c < 0 -> Error(ColumnTooSmall)
    Position(column: c, ..) if c > 7 -> Error(ColumnTooLarge)
    _ -> Ok(Nil)
  }
}

pub fn can_attack(
  black_queen black_queen: Position,
  white_queen white_queen: Position,
) -> Bool {
  case black_queen, white_queen {
    Position(row: rq, ..), Position(row: rw, ..) if rq == rw -> True
    Position(column: cq, ..), Position(column: cw, ..) if cq == cw -> True
    Position(row: rq, column: cq), Position(row: rw, column: cw) ->
      int.absolute_value(rq - rw) == int.absolute_value(cq - cw)
  }
}
