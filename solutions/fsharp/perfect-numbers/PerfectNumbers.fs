module PerfectNumbers

type Classification =
    | Perfect
    | Abundant
    | Deficient

let (|IsGreaterThan|IsEqualTo|IsLessThan|IsInvalid|) (a, b) =
    match a with
    | _ when b <= 0 -> IsInvalid
    | n when n > b -> IsGreaterThan
    | n when n < b -> IsLessThan
    | _ -> IsEqualTo

let aliquotSum (n: int) =
    [| 1 .. n |> (float >> sqrt >> int) |]
    |> Array.filter (fun i -> n % i = 0)
    |> Array.map
        (fun i ->
            if pown i 2 = n then
                [| i |]
            else
                [| i; n / i |])
    |> Array.concat
    |> Array.filter (fun i -> i <> n)
    |> Array.sum
    
let classify n : Classification option =
    match (aliquotSum n, n) with
    | IsInvalid -> None
    | IsGreaterThan -> Some Abundant
    | IsEqualTo -> Some Perfect
    | IsLessThan -> Some Deficient
