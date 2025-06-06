import gleam/map.{type Map}
import gleam/string
import gleam/list

pub type Player {
  X
  O
  None
}

type Posn {
  Posn(i: Int, j: Int)
}

type Board =
  Map(Posn, Player)

pub fn winner(input: String) -> Result(Player, Nil) {
  let #(board, rows, cols) = to_board(input)

  case is_winning_route(board, O, rows) {
    True -> Ok(O)
    False ->
      case is_winning_route(board, X, cols) {
        True -> Ok(X)
        False -> Error(Nil)
      }
  }
}

fn is_winning_route(board: Board, player: Player, target: Int) -> Bool {
  let pieces = map.filter(board, fn(_, v) { v == player })
  let starting_posns =
    map.filter(
      pieces,
      fn(k, _) {
        case player {
          O -> k.i == 0
          X -> k.j == 0
          _ -> panic
        }
      },
    )
    |> map.keys()

  list.any(starting_posns, is_connected(_, pieces, player, target))
}

fn is_connected(
  current: Posn,
  board: Board,
  player: Player,
  target: Int,
) -> Bool {
  case player, current, target {
    O, Posn(i, _), t if i == t -> True
    X, Posn(_, j), t if j == t -> True
    _, _, _ -> {
      let rest = map.delete(board, current)
      neighbors_of(current)
      |> list.filter(map.has_key(rest, _))
      |> list.any(is_connected(_, rest, player, target))
    }
  }
}

fn to_board(str: String) -> #(Board, Int, Int) {
  let rows = case string.split(str, "\n") {
    [_] as row -> row
    [_, ..rows] -> rows
  }

  let cols = case rows {
    [] -> 0
    [row, ..] ->
      row
      |> string.replace(" ", "")
      |> string.length()
  }

  let board =
    {
      use i, row <- list.index_map(rows)
      use j, col <- list.index_map(
        row
        |> string.replace(" ", "")
        |> string.to_graphemes(),
      )
      #(Posn(i, j), to_player(col))
    }
    |> list.flatten()
    |> map.from_list()
  #(board, list.length(rows) - 1, cols - 1)
}

fn to_player(chr: String) -> Player {
  case chr {
    "." -> None
    "X" -> X
    "O" -> O
  }
}

fn neighbors_of(p: Posn) -> List(Posn) {
  let Posn(i, j) = p
  [
    Posn(i, j - 1),
    Posn(i, j + 1),
    Posn(i + 1, j),
    Posn(i - 1, j),
    Posn(i + 1, j - 1),
    Posn(i - 1, j + 1),
  ]
}
