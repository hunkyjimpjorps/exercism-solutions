import gleam/list
import gleam/int
import gleam/result
import gleam/bool

pub opaque type Frame {
  Frame(rolls: List(Int), bonus: Int, result: FrameResult)
}

type FrameResult {
  Strike
  Spare
  Incomplete
  Complete
  TenthComplete
}

pub type Game {
  Game(frames: List(Frame))
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

pub fn roll(game: Game, pins: Int) -> Result(Game, Error) {
  case game {
    Game([_, _, _, _, _, _, _, _, _, _] as frames) -> {
      let assert [tenth, ninth, ..rest] = frames
      use <- bool.guard(tenth.result == TenthComplete, Error(GameComplete))
      case ninth.result, tenth.rolls {
        Strike, [_] ->
          handle_tenth_frame(tenth, pins)
          |> result.map(fn(f) { Game([f, add_bonus(ninth, pins), ..rest]) })
        _, _ ->
          handle_tenth_frame(tenth, pins)
          |> result.map(fn(f) { Game([f, ninth, ..rest]) })
      }
    }

    Game([]) ->
      new_frame()
      |> add_roll(pins)
      |> result.map(fn(f) { Game([f]) })

    Game(frames) ->
      case list.map(frames, fn(f) { f.result }) {
        [Strike, Strike, ..] -> {
          let assert [frame1, frame2, ..rest] = frames
          new_frame()
          |> add_roll(pins)
          |> result.map(fn(f) {
            Game([f, add_bonus(frame1, pins), add_bonus(frame2, pins), ..rest])
          })
        }

        [Spare, ..] | [Strike, ..] -> {
          let assert [frame, ..rest] = frames
          new_frame()
          |> add_roll(pins)
          |> result.map(fn(f) { Game([f, add_bonus(frame, pins), ..rest]) })
        }

        [Incomplete, Strike, ..] -> {
          let assert [frame1, frame2, ..rest] = frames
          frame1
          |> add_roll(pins)
          |> result.map(fn(f) { Game([f, add_bonus(frame2, pins), ..rest]) })
        }

        [Complete, ..] ->
          new_frame()
          |> add_roll(pins)
          |> result.map(fn(f) { Game([f, ..frames]) })

        [Incomplete, ..] -> {
          let assert [frame, ..rest] = frames
          frame
          |> add_roll(pins)
          |> result.map(fn(f) { Game([f, ..rest]) })
        }
        _ -> panic as "impossible frame"
      }
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  case game {
    Game([Frame(result: TenthComplete, ..), ..]) ->
      game.frames
      |> list.fold(0, fn(acc, f) { acc + int.sum(f.rolls) + f.bonus })
      |> Ok()
    _ -> Error(GameNotComplete)
  }
}

fn new_frame() -> Frame {
  Frame(rolls: [], bonus: 0, result: Incomplete)
}

fn add_roll(f: Frame, pins: Int) -> Result(Frame, Error) {
  case f.rolls {
    [] ->
      case pins {
        n if n > 10 || n < 0 -> Error(InvalidPinCount)
        10 -> Ok(Frame(..f, rolls: [10], result: Strike))
        n -> Ok(Frame(..f, rolls: [n]))
      }
    [first] ->
      case pins + first {
        total if total > 10 || pins < 0 -> Error(InvalidPinCount)
        total if total == 10 ->
          Ok(Frame(..f, rolls: [first, pins], result: Spare))
        _ -> Ok(Frame(..f, rolls: [first, pins], result: Complete))
      }
    _ -> panic as "impossible frame"
  }
}

fn add_bonus(f: Frame, bonus: Int) -> Frame {
  Frame(..f, bonus: f.bonus + bonus)
}

fn handle_tenth_frame(f: Frame, pins: Int) -> Result(Frame, Error) {
  case f {
    Frame(result: Strike, rolls: [r], ..) as f ->
      case pins {
        p if p < 0 || p > 10 -> Error(InvalidPinCount)
        p -> Ok(Frame(..f, result: Strike, rolls: [p, r]))
      }
    Frame(result: Strike, rolls: [r2, r1], ..) as f
    | Frame(result: Spare, rolls: [r2, r1], ..) as f ->
      case r2, r1 + r2, pins + r2 {
        10, _, _ if pins <= 10 ->
          Ok(Frame(..f, result: TenthComplete, rolls: [pins, r2, r1]))
        _, 10, _ if pins <= 10 ->
          Ok(Frame(..f, result: TenthComplete, rolls: [pins, r2, r1]))
        _, _, sum if sum < 0 || sum > 10 -> Error(InvalidPinCount)
        _, _, _ -> Ok(Frame(..f, result: TenthComplete, rolls: [pins, r2, r1]))
      }
    Frame(result: Incomplete, rolls: [r], ..) as f ->
      case pins + r {
        total if total > 10 || pins < 0 -> Error(InvalidPinCount)
        10 -> Ok(Frame(..f, result: Spare, rolls: [pins, r]))
        _ -> Ok(Frame(..f, result: TenthComplete, rolls: [pins, r]))
      }
    _ -> panic as "impossible frame"
  }
}
