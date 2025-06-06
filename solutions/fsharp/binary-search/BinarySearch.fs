module BinarySearch

let find (input: int array) (value: int) : int option =
    let rec findrec (input: (int * int) array)=
        match input with
        | [||] -> None
        | [| n |] when (snd n) = value -> Some(fst n)
        | _ ->
            Array.item (input.Length / 2) input
            |> snd
            |> function
            | n when n = value -> Some(fst input.[input.Length / 2])
            | n when n < value -> findrec input.[input.Length / 2 + 1..]
            | _ -> findrec input.[..input.Length / 2 - 1]

    findrec (Array.indexed input)
