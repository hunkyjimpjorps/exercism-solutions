module Hamming

let distance (strand1: string) (strand2: string) : int option =
    try
        List.map2 (fun (s1: char) (s2: char) -> s1 <> s2) (strand1 |> List.ofSeq) (strand2 |> List.ofSeq)
        |> List.filter id
        |> List.length
        |> Some
    with _ -> None
