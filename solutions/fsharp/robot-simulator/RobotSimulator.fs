module RobotSimulator

type Direction =
    | North
    | East
    | South
    | West

type Position = int * int

type Robot =
    { direction: Direction
      position: Position }

let create (d: Direction) (p: Position) : Robot = { direction = d; position = p }

let turnRight (r: Robot) : Robot =
    let newFacing =
        match r.direction with
        | North -> East
        | East -> South
        | South -> West
        | West -> North

    { r with direction = newFacing }

let turnLeft (r: Robot) : Robot =
    let newFacing =
        match r.direction with
        | North -> West
        | East -> North
        | South -> East
        | West -> South

    { r with direction = newFacing }

let goForward (r: Robot) : Robot =
    let (x, y) = r.position

    let newPosition =
        match r.direction with
        | North -> (x, y + 1)
        | East -> (x + 1, y)
        | South -> (x, y - 1)
        | West -> (x - 1, y)

    { r with position = newPosition }

let move (instructions: string) (initialR: Robot) : Robot =
    let instructionsList = Seq.toList instructions

    let rec nextInstruction (instList: char list) (movingR: Robot) =
        match instList with
        | [] -> movingR
        | head :: tail ->
            match head with
            | 'L' -> nextInstruction tail (turnLeft movingR)
            | 'R' -> nextInstruction tail (turnRight movingR)
            | 'A' -> nextInstruction tail (goForward movingR)
            | _ -> invalidArg (string head) "Invalid direction"

    nextInstruction instructionsList initialR
