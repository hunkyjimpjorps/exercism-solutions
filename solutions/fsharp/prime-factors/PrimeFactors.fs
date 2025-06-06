module PrimeFactors

let factors (number: int64) : int list =

    let rec nextFactor remainder candidate acc =
        match (remainder, candidate) with
        | r, _ when r <= 1L -> acc
        | r, n when r % n = 0L -> nextFactor (r / n) n (acc @ [ int n ])
        | r, 2L -> nextFactor r 3L acc
        | r, n -> nextFactor r (n + 2L) acc // no reason to check even numbers after 2

    nextFactor number 2L List.empty
