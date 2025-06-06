module SimpleLinkedList

type SimpleLinkedList =
    | Cons of int * SimpleLinkedList
    | Nil

let nil: SimpleLinkedList = Nil

let create (first: int) (rest: SimpleLinkedList) : SimpleLinkedList = Cons(first, rest)

let isNil (linkedList: SimpleLinkedList) : bool = linkedList = Nil

let next (linkedList: SimpleLinkedList) : SimpleLinkedList =
    match linkedList with
    | Cons(_, rest) -> rest
    | Nil -> Nil

let datum (linkedList: SimpleLinkedList) : int =
    match linkedList with
    | Cons(first, _) -> first
    | Nil -> failwith "nil"

let rec toList (linkedList: SimpleLinkedList) : int list =
    match linkedList with
    | Cons(first, rest) -> first :: toList rest
    | Nil -> []

let rec fromList (lst: int list) : SimpleLinkedList =
    match lst with
    | x :: rest -> create x (fromList rest)
    | [] -> nil

let reverse (linkedList: SimpleLinkedList) : SimpleLinkedList =
    let rec doReverse acc linkedList =
        match linkedList with
        | Cons(first, rest) -> doReverse (create first acc) rest
        | Nil -> acc

    doReverse nil linkedList
