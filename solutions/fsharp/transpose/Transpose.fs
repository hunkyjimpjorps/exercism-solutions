module Transpose


let maybeTail: 'a list -> 'a list =
    function
    | [] -> []
    | _ :: t -> t

let rec swap (acc: char list list) (input: char list list) : char list list =
    let candidates = List.map List.tryHead input

    if List.filter Option.isSome candidates |> List.isEmpty then
        List.rev acc
    else
        let trimmed_heads =
            candidates
            |> List.rev
            |> List.skipWhile Option.isNone
            |> List.rev
            |> List.map (Option.defaultValue ' ')

        swap (trimmed_heads :: acc) (List.map maybeTail input)

let transpose (input: string list) : string list =
    input
    |> List.map Seq.toList
    |> swap []
    |> List.map (fun (chrs: char list) -> chrs |> List.toArray |> System.String.Concat)
