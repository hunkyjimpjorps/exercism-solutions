module ReverseString

let reverse (input: string) : string =
    let rec reverseRecursive (input: char list) (acc: char list) : string =
        match input with
        | [] -> acc |> System.String.Concat
        | h :: t -> reverseRecursive t (h :: acc)

    reverseRecursive (input |> Seq.toList) List.empty
