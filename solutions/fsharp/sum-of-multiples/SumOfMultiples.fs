module SumOfMultiples

let sum (numbers: int list) (upperBound: int) : int =
    seq {
        for n in numbers do
            match n with
            | 0 -> Seq.empty
            | _ -> seq { n .. n .. upperBound - 1 }
    }
    |> Seq.concat
    |> Seq.distinct
    |> Seq.fold (+) 0
