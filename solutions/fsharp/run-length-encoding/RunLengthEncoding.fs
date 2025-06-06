module RunLengthEncoding

open System.Text.RegularExpressions

let encodeOneChar c i =
    if i = 1 then
        string c
    else
        string i + string c

let encode (input: string) =
    let rec encodeNext (input: char list) (encodeAcc: string) (charAcc: char) (countAcc: int) =
        match input with
        | [] -> $"{encodeAcc}{encodeOneChar charAcc countAcc}"
        | h :: t when h = charAcc -> encodeNext t encodeAcc charAcc (countAcc + 1)
        | h :: t -> encodeNext t $"{encodeAcc}{encodeOneChar charAcc countAcc}" h 1

    if input = "" then
        ""
    else
        encodeNext (Seq.toList input) "" (char input.[0]) 0

let expandAbbreviation (abbrev: string) =
    if abbrev.Length = 1 then
        abbrev
    else
        Regex.Matches(abbrev, "(\d+)?(.)").[0].Groups
        |> Seq.map (fun m -> m.Value)
        |> Seq.toList
        |> (fun s -> List.replicate (int s.[1]) s.[2])
        |> System.String.Concat

let decode input =
    if input = "" then
        ""
    else
        Regex.Matches(input, "(\d+)?[a-zA-Z\s]")
        |> Seq.map ((fun m -> m.Value) >> expandAbbreviation)
        |> System.String.Concat
