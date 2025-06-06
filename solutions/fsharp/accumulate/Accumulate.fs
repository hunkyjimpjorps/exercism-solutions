module Accumulate

let accumulate (func: 'a -> 'b) (input: 'a list) : 'b list =
    let rec acc_internal func input acc =
        match input with
        | [] -> List.rev acc
        | car :: cdr -> acc_internal func cdr ((func car) :: acc)

    acc_internal func input []
