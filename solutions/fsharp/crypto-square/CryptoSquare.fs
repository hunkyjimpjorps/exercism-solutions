module CryptoSquare

open System.Text.RegularExpressions

let determineSize (n: int) : (int * int) =
    let rec nextSize =
        function
        | n, c when n <= c * (c - 1) -> (c, c - 1)
        | n, c when n <= c * c -> (c, c)
        | n, c -> nextSize (n, c + 1)

    nextSize (n, 1)

let ciphertext (input: string) =
    let padAndChunkString (str: string) =
        let r, c = determineSize str.Length
        str.PadRight(r * c) |> Seq.chunkBySize r

    input.ToLower()
    |> fun str -> Regex.Replace(str, "[^a-z0-9]", "")
    |> padAndChunkString
    |> Seq.transpose
    |> Seq.map System.String.Concat
    |> fun arr -> System.String.Join(' ', arr)
