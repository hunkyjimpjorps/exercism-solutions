module DifferenceOfSquares

let squareOfSum (number: int) : int =
    seq { 1 .. number }
    |> Seq.sum
    |> (fun x -> pown x 2)

let sumOfSquares (number: int) : int =
    seq { 1 .. number }
    |> Seq.map (fun x -> pown x 2)
    |> Seq.sum

let differenceOfSquares (number: int) : int =
    squareOfSum number - sumOfSquares number
