module BinarySearch

let find (input: int array) (value: int) : int option =
    let inputIndexed = Array.indexed input

    let rec findrec (input: (int * int) array) value =
        match input with
        | [||] -> None
        | [| n |] when (snd n) = value -> Some(fst n)
        | _ ->
            Array.item (input.Length / 2) input
            |> snd
            |> function
            | n when n = value -> Some(fst input.[input.Length / 2])
            | n when n < value -> findrec input.[input.Length / 2 + 1..] value
            | n when n > value -> findrec input.[..input.Length / 2 - 1] value
            | _ -> failwith "Comparison error"

    findrec inputIndexed value
