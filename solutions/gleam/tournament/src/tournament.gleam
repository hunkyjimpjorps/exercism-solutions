import gleam/map.{Map}
import gleam/option.{None, Option, Some}
import gleam/order.{Eq, Order}
import gleam/string
import gleam/list
import gleam/int

type League =
  Map(String, Stats)

type Stats {
  Stats(mp: Int, w: Int, d: Int)
}

const header = "Team                           | MP |  W |  D |  L |  P"

pub fn tally(input: String) -> String {
  input
  |> string.split(on: "\n")
  |> list.fold(from: new_league(), with: add_next_result)
  |> map.to_list()
  |> list.sort(compare_teams)
  |> list.map(display_stats)
  |> list.prepend(header)
  |> string.join("\n")
}

fn new_league() -> League {
  map.new()
}

fn add_next_result(league: League, match: String) -> League {
  case string.split(match, on: ";") {
    [""] -> league
    [home, away, result] ->
      case result {
        "win" ->
          league
          |> map.update(home, win)
          |> map.update(away, loss)
        "loss" ->
          league
          |> map.update(home, loss)
          |> map.update(away, win)
        "draw" ->
          league
          |> map.update(home, draw)
          |> map.update(away, draw)
        _ -> panic as "Unknown game result"
      }
    _ -> panic as "Unknown game format"
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
