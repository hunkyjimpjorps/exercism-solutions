module Sieve

let primes limit =
    let rec nextSieve candidates acc =
        match candidates with
        // The list will be empty if limit < 2
        | [] -> acc
        // We can stop iterating over the list once we reach a head value whose square
        // is greater than the limit, since all its multiples will have been already
        // sieved by earlier steps
        // Since we pre-sieved out 2 when making the initial list, we add it back in now
        | h :: t when pown h 2 > limit -> 2 :: (List.rev acc @ candidates)
        // For the same reason, we don't have to check to filter out multiples lower than h * h
        // since 2h, 3h, 4h... will have already been removed
        // We also don't need to check even multiples
        | h :: t -> nextSieve (List.except [ pown h 2 .. 2 * h .. limit ] t) (h :: acc)

    match limit with
    | n when n < 2 -> []
    | 2 -> [ 2 ]
    // Pre-filter all even numbers to eliminate the most intensive step
    | _ -> nextSieve [ 3 .. 2 .. limit ] List.empty
