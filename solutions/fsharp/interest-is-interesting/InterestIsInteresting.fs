module InterestIsInteresting

let (|LessThan|_|) limit x = if x < limit then Some x else None

let interestRate (balance: decimal) : single =
    match balance with
    | LessThan 0m x -> 3.213f
    | LessThan 1000m x -> 0.50f
    | LessThan 5000m x -> 1.621f
    | _ -> 2.475f

let interest (balance: decimal) : decimal =
    balance * decimal (interestRate balance) / 100m

let annualBalanceUpdate (balance: decimal) : decimal = balance + interest balance

let amountToDonate (balance: decimal) (taxFreePercentage: float) : int =
    if balance > 0m then
        balance
        |> (*) (decimal taxFreePercentage / 100m)
        |> (*) 2m
        |> int
    else
        0
