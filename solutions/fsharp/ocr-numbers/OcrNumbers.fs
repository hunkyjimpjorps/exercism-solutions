module OcrNumbers
let splitIntoCharBlocks strs =
    strs 
    |> List.map (Seq.toList >> List.chunkBySize 3)
    |> List.transpose
    |> List.map (List.concat >> List.toArray >> string)

let chars =
    [ 
    " _     _  _     _  _  _  _  _ ";
    "| |  | _| _||_||_ |_   ||_||_|";
    "|_|  ||_  _|  | _||_|  ||_| _|";
    "                              " 
    ] |> splitIntoCharBlocks

let charMap =
    chars
    |> List.mapi (fun i chrs -> chrs, string i)
    |> Map.ofList

let convertOne input = 
    Map.tryFind input charMap |> Option.defaultValue "?"

let convertLine input =
    input 
    |> splitIntoCharBlocks
    |> List.map convertOne
    |> String.concat ""

let convert input =
    if List.length input % 4 <> 0 || List.exists (fun str -> String.length str % 3 <> 0) input then
        None
    else
        input
        |> List.chunkBySize 4
        |> List.map convertLine
        |> String.concat ","
        |> Some