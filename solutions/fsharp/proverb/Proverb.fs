module Proverb

let recite (input: string list) : string list =
    let inputCycle : string list =
        match input with
        | [] -> []
        | [ one ] -> [ one ]
        | _ -> List.append input [ (List.head input) ]

    let rec reciteCycle (i: string list) (acc: string list) : string list =
        match i with
        | one :: two :: rest when not rest.IsEmpty ->
            reciteCycle (two :: rest) ($"For want of a {one} the {two} was lost." :: acc)
        | _ :: two :: [] -> $"And all for the want of a {two}." :: acc
        | one :: [] -> $"And all for the want of a {one}." :: acc
        | [] -> []

    reciteCycle inputCycle [] |> List.rev
