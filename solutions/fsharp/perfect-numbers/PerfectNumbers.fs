module PerfectNumbers

type Classification =
    | Perfect
    | Abundant
    | Deficient

let (|IsGreaterThan|IsEqualTo|IsLessThan|IsInvalid|) =
    function
    | (_, b) when b <= 0 -> IsInvalid
    | (a, b) when a > b -> IsGreaterThan
    | (a, b) when a < b -> IsLessThan
    | _ -> IsEqualTo

let aliquotSum (n: int) =
    (Array.collect
        (fun i ->
            if i = n then
                Array.empty
            else if pown i 2 = n || i = 1 then
                [| i |]
            else
                [| i; n / i |])
        ([| 1 .. n |> (float >> sqrt >> int) |]
         |> Array.filter (fun i -> n % i = 0)))
    |> Array.sum

let classify n : Classification option =
    match (aliquotSum n, n) with
    | IsInvalid -> None
    | IsGreaterThan -> Some Abundant
    | IsEqualTo -> Some Perfect
    | IsLessThan -> Some Deficient
