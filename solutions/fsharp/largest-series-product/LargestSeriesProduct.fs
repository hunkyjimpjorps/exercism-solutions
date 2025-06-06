// Uses FsRegEx library.
module LargestSeriesProduct

let (|ValidNumber|) (input: string, _) : bool =
    FsRegEx.isMatch @"^[0-9]*$" input

let (|ZeroWindow|) (_, seriesLength) : bool = seriesLength = 0

let (|InvalidWindow|) (input, seriesLength) : bool =
    seriesLength > String.length input
    || seriesLength < 0

let (|EmptyString|) (input, _) : bool = input = ""

let largestProduct input seriesLength : int option =
    match (input, seriesLength) with
    | ValidNumber false -> None
    | InvalidWindow true -> None
    | ZeroWindow true -> Some 1
    | EmptyString true -> None
    | _ ->
        input
        |> Seq.windowed seriesLength
        |> Seq.map (Seq.fold (fun acc i -> acc * (string >> int) i) 1)
        |> Seq.max
        |> Some
