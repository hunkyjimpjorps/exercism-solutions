module Sieve

let primes limit =
    let rec nextSieve candidates acc =
        match candidates with
        // The list will be empty if limit < 2
        | [] -> acc
        // We can stop iterating over the list once we reach a head value whose square
        // is greater than the limit, since all its multiples will have been already
        // sieved by earlier steps
        // i.e. for a limit of 100, for h = 11,
        // h = 2 will have filtered 22, 44, 66, 88,
        // h = 3 will have filtered 33, 99,
        // h = 5 will have filtered 55,
        // h = 7 will have filtered 77, so all multiples of 11 < 100 are accounted for already
        | h :: t when pown h 2 > limit -> List.rev acc @ candidates
        // For the same reason, we don't have to check to filter out multiples lower than h * h
        // since 2h, 3h, 4h... will have already been removed
        | h :: t -> nextSieve (List.except [ pown h 2 .. h .. limit ] t) (h :: acc)

    nextSieve [ 2 .. limit ] List.empty
