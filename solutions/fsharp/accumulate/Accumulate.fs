module Accumulate

let accumulate (func: 'a -> 'b) (input: 'a list) : 'b list =
    let rec acc_internal lst acc =
        match lst with
        | [] -> List.rev acc
        | car :: cdr -> acc_internal cdr ((func car) :: acc)

    acc_internal input []
