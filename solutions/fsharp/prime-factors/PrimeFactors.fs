module PrimeFactors

let factors (number: int64) : int list =

    let rec nextFactor remainder candidate acc =
        match candidate with
        | _ when remainder = 1L -> acc
        | n when remainder % n = 0L -> nextFactor (remainder / n) n (acc @ [ int n ])
        | _ -> nextFactor remainder (candidate + 1L) acc

    nextFactor number 2L List.empty