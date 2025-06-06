import gleam/string
import gleam/list

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction: direction, position: position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  do_moves(create(direction, position), instructions)
}

fn do_moves(robot: Robot, instructions: String) -> Robot {
  case string.pop_grapheme(instructions) {
    Error(Nil) -> robot
    Ok(#(h, t)) ->
      case h {
        "R" -> turn_right(robot)
        "L" -> turn_left(robot)
        "A" -> advance(robot)
      }
      |> do_moves(t)
  }
}

fn turn_right(robot: Robot) -> Robot {
  case robot.direction {
    North -> East
    East -> South
    South -> West
    West -> North
  }
  |> fn(d) { Robot(..robot, direction: d) }
}

fn turn_left(robot: Robot) -> Robot {
  case robot.direction {
    North -> West
    West -> South
    South -> East
    East -> North
  }
  |> fn(d) { Robot(..robot, direction: d) }
}

fn advance(robot: Robot) -> Robot {
  case robot.direction {
    North -> Position(..robot.position, y: robot.position.y + 1)
    East -> Position(..robot.position, x: robot.position.x + 1)
    South -> Position(..robot.position, y: robot.position.y - 1)
    West -> Position(..robot.position, x: robot.position.x - 1)
  }
  |> fn(p) { Robot(..robot, position: p) }
}
