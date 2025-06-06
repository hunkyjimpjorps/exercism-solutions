import gleam/dict.{type Dict}
import gleam/option.{None, type Option, Some}
import gleam/order.{Eq, type Order}
import gleam/string
import gleam/list
import gleam/int
import gleam/result

type League =
  Dict(String, Stats)

type Stats {
  Stats(mp: Int, w: Int, d: Int)
}

type ParsingError {
  InvalidGameFormat
  InvalidGameResult
}

const header = "Team                           | MP |  W |  D |  L |  P"

pub fn tally(input: String) -> String {
  input
  |> string.split(on: "\n")
  |> list.try_fold(from: new_league(), with: add_next_result)
  |> result.map(fn(teams) {
    teams
    |> dict.to_list()
    |> list.sort(compare_teams)
    |> list.map(display_stats)
    |> list.prepend(header)
    |> string.join("\n")
  })
  // pipe would end here if the tests would accept Result(String, _)
  |> result.unwrap(or: "invalid parsing handling goes here")
}

fn new_league() -> League {
  dict.new()
}

fn add_next_result(
  league: League,
  match: String,
) -> Result(League, ParsingError) {
  case string.split(match, on: ";") {
    [""] -> Ok(league)
    [home, away, result] ->
      case result {
        "win" ->
          league
          |> dict.update(home, win)
          |> dict.update(away, loss)
          |> Ok()
        "loss" ->
          league
          |> dict.update(home, loss)
          |> dict.update(away, win)
          |> Ok()
        "draw" ->
          league
          |> dict.update(home, draw)
          |> dict.update(away, draw)
          |> Ok()
        _ -> Error(InvalidGameResult)
      }
    _ -> Error(InvalidGameFormat)
  }
}

fn win(s: Option(Stats)) -> Stats {
  case s {
    Some(s) -> Stats(..s, mp: s.mp + 1, w: s.w + 1)
    None -> Stats(mp: 1, w: 1, d: 0)
  }
}

fn loss(s: Option(Stats)) -> Stats {
  case s {
    Some(s) -> Stats(..s, mp: s.mp + 1)
    None -> Stats(mp: 1, w: 0, d: 0)
  }
}

fn draw(s: Option(Stats)) -> Stats {
  case s {
    Some(s) -> Stats(..s, mp: s.mp + 1, d: s.d + 1)
    None -> Stats(mp: 1, w: 0, d: 1)
  }
}

fn score(s: Stats) -> Int {
  s.w * 3 + s.d
}

fn compare_teams(t1: #(String, Stats), t2: #(String, Stats)) -> Order {
  let #(n1, s1) = t1
  let #(n2, s2) = t2
  case int.compare(score(s2), score(s1)) {
    Eq -> string.compare(n1, n2)
    r -> r
  }
}

fn stat_to_string(n: Int) -> String {
  n
  |> int.to_string()
  |> string.pad_left(2, " ")
}

fn display_stats(t: #(String, Stats)) -> String {
  let #(name, s) = t
  [s.mp, s.w, s.d, s.mp - s.w - s.d, score(s)]
  |> list.map(stat_to_string)
  |> list.prepend(string.pad_right(name, 30, " "))
  |> string.join(" | ")
}
