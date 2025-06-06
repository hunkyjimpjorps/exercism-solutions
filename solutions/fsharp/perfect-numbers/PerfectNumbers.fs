module PerfectNumbers

type Classification =
    | Perfect
    | Abundant
    | Deficient

let (|IsGreaterThan|IsEqualTo|IsLessThan|IsInvalid|) (a, b) =
    match a with
    | _ when b <= 0 -> IsInvalid
    | _ when a > b -> IsGreaterThan
    | _ when a < b -> IsLessThan
    | _ -> IsEqualTo

let aliquotSum (n: int) =
    [| 1 .. n |> (float >> sqrt >> int) |]
    |> Array.filter (fun i -> n % i = 0)
    |> Array.map
        (fun i ->
            if i = n then
                Array.empty
            else if pown i 2 = n || i = 1 then
                [| i |]
            else
                [| i; n / i |])
    |> Array.concat
    |> Array.sum

let classify n : Classification option =
    match (aliquotSum n, n) with
    | IsInvalid -> None
    | IsGreaterThan -> Some Abundant
    | IsEqualTo -> Some Perfect
    | IsLessThan -> Some Deficient
