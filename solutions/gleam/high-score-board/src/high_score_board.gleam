import gleam/map.{Map}
import gleam/option

pub type ScoreBoard =
  Map(String, Int)

pub fn create_score_board() -> ScoreBoard {
  map.from_list([#("The Best Ever", 1_000_000)])
}

pub fn add_player(
  score_board: ScoreBoard,
  player: String,
  score: Int,
) -> ScoreBoard {
  map.insert(score_board, player, score)
}

pub fn remove_player(score_board: ScoreBoard, player: String) -> ScoreBoard {
  map.drop(score_board, [player])
}

pub fn update_score(
  score_board: ScoreBoard,
  player: String,
  points: Int,
) -> ScoreBoard {
  case map.get(score_board, player) {
    Ok(s) -> map.insert(score_board, player, s + points)
    Error(_) -> score_board
  }
}

pub fn apply_monday_bonus(score_board: ScoreBoard) -> ScoreBoard {
  map.map_values(score_board, fn(_, s) { s + 100 })
}
