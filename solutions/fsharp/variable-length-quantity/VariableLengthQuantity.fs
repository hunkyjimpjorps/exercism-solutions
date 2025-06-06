module VariableLengthQuantity

let baseVLQuint = 0x80u
let baseVLQbyte = baseVLQuint |> byte

let rec findMaxBase b i n =
    if n / b = 0u then
        i
    else
        findMaxBase b (i + 1) (n / b)

let rec toNewBase b i acc n : byte list =
    match i with
    | -1 -> acc |> List.rev |> List.map byte
    | _ -> toNewBase b (i - 1) ((n / (pown b i)) :: acc) (n % (pown b i))

let flipVLQBytes (bytes: byte list) =
    match bytes.Length with
    | 1 -> bytes
    | _ ->
        List.append
            (bytes.[..bytes.Length - 2]
             |> List.map (fun b -> b ||| baseVLQbyte))
            [ List.last bytes ]

let encode (number: uint32 list) =
    number
    |> List.collect (
        (fun n -> toNewBase baseVLQuint (findMaxBase baseVLQuint 0 n) [] n)
        >> flipVLQBytes
    )

let rec groupBytes (lst: byte list) (byteAcc: byte list) (allBytes: byte list list) =
    match lst with
    | [] when byteAcc.IsEmpty -> allBytes |> List.rev |> Some
    | h :: t when h &&& baseVLQbyte = baseVLQbyte -> groupBytes t ((h ^^^ baseVLQbyte) :: byteAcc) allBytes
    | h :: t -> groupBytes t [] ((h :: byteAcc) :: allBytes)
    | [] -> None

let rec sumBytes (lst: byte list) =
    lst
    |> List.mapi (fun i b -> uint32 b * pown baseVLQuint i)
    |> List.sum

let decode bytes =
    match groupBytes bytes List.empty List.empty with
    | Some b -> b |> List.map sumBytes |> Some
    | None -> None
