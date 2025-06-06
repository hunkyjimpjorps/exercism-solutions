module Minesweeper

type Cell =
    | Mine
    | Empty

type Coordinate = int * int
type Board = Map<Coordinate, Cell>
type BoardRepresentation = string list

let charToCell ch =
    match ch with
    | '*' -> Mine
    | ' ' -> Empty
    | _ -> failwith "Invalid char"

let inputToMap (input: BoardRepresentation) : Board =
    [ for i, row in List.indexed input do
          for j, ch in Seq.indexed row -> ((i, j), charToCell ch) ]
    |> Map.ofList

let adjacentCoordinates (coord: Coordinate) : Coordinate list =
    let x, y = coord

    [ for dx, dy in List.allPairs [ -1 .. 1 ] [ -1 .. 1 ] do
          if (dx, dy) <> (0, 0) then
              (dx + x, dy + y) ]

let countNeighborsOrHitMine (coord: Coordinate) (board: Board) =
    match Map.find coord board with
    | Mine -> "*"
    | Empty ->
        coord
        |> adjacentCoordinates
        |> List.filter (fun c -> Map.tryFind c board = Some Mine)
        |> List.length
        |> (fun i -> if i = 0 then " " else string i)

let annotate (input: BoardRepresentation) : BoardRepresentation =
    let imax = List.length input - 1

    let jmax =
        match input with
        | [] -> 0
        | first :: _ -> String.length first - 1

    let board = inputToMap input

    [ for i in 0..imax -> String.concat "" [ for j in 0..jmax -> countNeighborsOrHitMine (i, j) board ] ]
