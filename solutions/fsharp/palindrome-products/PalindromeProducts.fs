module PalindromeProducts

let rec isPalindrome number =
    let str = string number
    str = (str |> Seq.rev |> System.String.Concat)

let product (a, b) = a * b

let makeFactors (minFactor: int) (maxFactor: int) =
    if minFactor > maxFactor then
        raise (System.ArgumentException())

    [ for a in minFactor..maxFactor do
          for b in a..maxFactor do
              if isPalindrome (a * b) then
                  yield (a, b) ]
    |> List.groupBy product

let toResult (n, ps) = (Some n, ps)

let largest minFactor maxFactor =
    match makeFactors minFactor maxFactor with
    | [] -> (None, [])
    | factors -> factors |> List.maxBy fst |> toResult

let smallest minFactor maxFactor =
    match makeFactors minFactor maxFactor with
    | [] -> (None, [])
    | factors -> factors |> List.minBy fst |> toResult
