module BinarySearch

let find (input: int array) (value: int) : int option =
    let rec findrec (subinput: (int * int) array) =
        match subinput with
        | [||] -> None
        | _ ->
            Array.item (subinput.Length / 2) subinput
            |> snd
            |> function
            | n when n = value -> Some(fst subinput.[subinput.Length / 2])
            | n when n < value -> findrec subinput.[subinput.Length / 2 + 1..]
            | _ -> findrec subinput.[..subinput.Length / 2 - 1]

    match value with
    | n when
        input = Array.empty
        || n < Array.head input
        || n > Array.last input -> None
    | _ -> findrec (Array.indexed input)
