module ListOps

let (|Empty|Full|) lst =
    match lst with
    | [] -> Empty
    | _ -> Full(List.head lst, List.tail lst)

let rec foldl (folder: 'T -> 'T -> 'T) (state: 'T) (lst: 'T list) : 'T =
    match lst with
    | Empty -> state
    | Full (h, t) -> foldl folder (folder state h) t

let rec foldr folder (state: 'T) (lst: 'T list) =
    foldl (fun x y -> folder y x) state (List.rev lst)

let length (lst: 'T list) : int =
    let rec lengthAcc lst acc : int =
        match lst with
        | Empty -> acc
        | Full (_, t) -> lengthAcc t (acc + 1)

    lengthAcc lst 0

let reverse (lst: 'T list) : 'T list =
    let rec reverseAcc lst acc =
        match lst with
        | Empty -> acc
        | Full (h, t) -> reverseAcc t (h :: acc)

    reverseAcc lst []

let map (f: 'T -> 'U) (lst: 'T list) : 'U list =
    match lst with
    | Empty -> []
    | Full (h, t) -> (f h) :: (List.map f t)

let rec filter (f: 'T -> bool) (lst: 'T list) : 'T list =
    match lst with
    | Empty -> []
    | Full (h, t) when f h -> h :: (filter f t)
    | Full (_, t) -> filter f t

let rec append (xs: 'T list) (ys: 'T list) : 'T list =
    match xs with
    | Empty -> ys
    | h :: [] -> h :: ys
    | Full (h, t) -> h :: (append t ys)

let rec concat xs =
    match xs with
    | Empty -> []
    | Full (h, t) -> append h (concat t)
