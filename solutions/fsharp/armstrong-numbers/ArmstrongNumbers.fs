module ArmstrongNumbers

let (|SumOfSquaresOfDigits|) (number: int) : bool =
    let digits = string number

    digits
    |> Seq.fold (fun acc i -> acc + pown (int (string i)) (Seq.length digits)) 0
    |> (=) number

let isArmstrongNumber (number: int) : bool =
    match number with
    | n when n < 0 -> false
    | SumOfSquaresOfDigits true -> true
    | _ -> false
