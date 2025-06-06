module QueenAttack

let onBoard = [| 0 .. 7 |]

let (|OnBoard|_|) (r, c) =
    if Array.contains r onBoard
       && Array.contains c onBoard then
        Some()
    else
        None

let create (position: int * int) =
    match position with
    | OnBoard -> true
    | _ -> false

let (|InSameRank|_|) ((r1, _), (r2, _)) = if r1 = r2 then Some() else None

let (|InSameFile|_|) ((_, c1), (_, c2)) = if c1 = c2 then Some() else None

let (|Diagonal|_|) ((r1, c1), (r2, c2)) =
    if abs (r1 - r2) = abs (c1 - c2) then
        Some()
    else
        None

let canAttack (queen1: int * int) (queen2: int * int) =
    match queen1, queen2 with
    | InSameRank
    | InSameFile
    | Diagonal -> true
    | _ -> false
