module Sublist

type SublistType =
    | Equal
    | Sublist
    | Superlist
    | Unequal

let makePattern x = if x then Some() else None
let (|IdenticalLists|_|) (xs, ys) = xs = ys |> makePattern

let findSubList (superlist: 'T list) (sublist: 'T list) =
    let len = Seq.length sublist

    match len with
    | 0 -> true
    | _ ->
        superlist
        |> Seq.windowed len
        |> Seq.map List.ofArray
        |> Seq.contains sublist

let (|XWithinY|_|) (xs, ys) = findSubList ys xs |> makePattern

let (|YWithinX|_|) (xs, ys) = findSubList xs ys |> makePattern

let sublist xs ys =
    match (xs, ys) with
    | IdenticalLists -> Equal
    | XWithinY -> Sublist
    | YWithinX -> Superlist
    | _ -> Unequal
