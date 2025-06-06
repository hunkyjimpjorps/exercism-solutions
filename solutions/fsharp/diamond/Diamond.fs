module Diamond

let letters = [| 'A' .. 'Z' |]

let padPattern n =
    Array.append [| n - 1 .. -1 .. 0 |] [| 1 .. n - 1 |]

let innerPadPattern n =
    padPattern n
    |> Array.map
        (function
        | i when i = n - 1 -> 0
        | i -> (2 * n - 1) - 2 - (2 * i))

let charPattern n =
    let firstHalf = [| 'A' .. n |]

    firstHalf
    |> Array.rev
    |> Array.tail
    |> Array.append firstHalf

let makeSpaces n =
    Array.create n " " |> System.String.Concat

let make (c: char) : string =
    let size = Array.findIndex (fun i -> i = c) letters

    charPattern c
    |> Array.zip3 (padPattern (size + 1)) (innerPadPattern (size + 1))
    |> Array.map (
        (function
        | outer, 0, 'A' ->
            [| (makeSpaces outer)
               ("A")
               (makeSpaces outer) |]
        | outer, inner, c ->
            [| (makeSpaces outer)
               (string c)
               (makeSpaces inner)
               (string c)
               (makeSpaces outer) |])
        >> System.String.Concat
    )
    |> fun xs -> System.String.Join("\n", xs)
