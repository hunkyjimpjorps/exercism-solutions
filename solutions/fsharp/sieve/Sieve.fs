module Sieve

let primes limit =
    let rec nextSieve candidates acc =
        match candidates with
        | [] -> acc |> List.rev
        | h :: t -> nextSieve (List.except [ 2 * h .. h .. limit ] t) (h :: acc)

    nextSieve [ 2 .. limit ] List.empty
