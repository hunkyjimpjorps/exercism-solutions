module VariableLengthQuantity

let rec findMaxBase n b i =
    if n >= pown b (i + 1) then
        findMaxBase n b (i + 1)
    else
        i

let rec toNewBase (b: int64) (n: int64) : byte list =
    let mutable digits = List.empty
    let mutable remaining = n

    for i in (findMaxBase n b 0) .. -1 .. 0 do
        digits <- digits @ [ remaining / (pown b i) ]
        remaining <- remaining % (pown b i)

    digits |> List.map byte

let flipVLQBytes (bytes: byte list) =
    match bytes.Length with
    | 1 -> bytes
    | _ ->
        List.append
            (bytes.[..bytes.Length - 2]
             |> List.map (fun b -> b ||| 128uy))
            [ List.last bytes ]

let encode (number: uint32 list) =
    number
    |> List.collect (int64 >> toNewBase 128L >> flipVLQBytes)

let rec groupBytes (lst: byte list) (byteAcc: byte list) (allBytes: byte list list) =
    match lst with
    | [] when byteAcc.IsEmpty -> Some allBytes
    | h :: t when h &&& 128uy = 128uy -> groupBytes t (byteAcc @ [ h ^^^ 128uy ]) allBytes
    | h :: t -> groupBytes t [] (allBytes @ [ byteAcc @ [ h ] ])
    | [] -> None

let rec sumBytes (lst: byte list) =
    lst
    |> List.rev
    |> List.mapi (fun i b -> uint32 b * pown 128u i)
    |> List.sum

let decode bytes =
    match groupBytes bytes List.empty List.empty with
    | Some b -> b |> List.map sumBytes |> Some
    | None -> None
