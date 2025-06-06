module CarsAssemble

let (|Between|) low high (x: int) : bool =
    x >= low && x <= high

let successRate (speed: int): float =
    match speed with
    | 0 -> 0
    | Between 1 4 true -> 1.00
    | Between 5 8 true -> 0.90
    | 9 -> 0.80
    | 10 -> 0.77
    | _ -> failwith "Out of range"

let productionRatePerHour (speed: int): float =
    221.0 * (float speed) * successRate speed

let workingItemsPerMinute (speed: int): int =
    productionRatePerHour speed / 60.0 |> int