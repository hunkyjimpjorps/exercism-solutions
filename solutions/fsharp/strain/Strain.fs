module Seq

let (|EmptySeq|FullSeq|) s =
    match s with
    | s when Seq.isEmpty s -> EmptySeq
    | _ -> FullSeq((Seq.head s), (Seq.skip 1 s))

let (|TruePredicate|_|) proc n =
    match n with
    | n when proc n -> Some n
    | _ -> None

let rec keep (pred: 'T -> bool) (xs: seq<'T>) : seq<'T> =
    match xs with
    | EmptySeq -> Seq.empty
    | FullSeq (head, tail) ->
        Seq.append
            (match head with
             | TruePredicate pred head -> [ head ]
             | _ -> [])
            (keep pred tail)

let rec discard pred xs =
    match xs with
    | EmptySeq -> Seq.empty
    | FullSeq (head, tail) ->
        Seq.append
            (match head with
             | TruePredicate pred _ -> []
             | head -> [ head ])
            (discard pred tail)
