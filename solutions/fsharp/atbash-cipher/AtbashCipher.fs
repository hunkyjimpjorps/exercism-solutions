module AtbashCipher

open System
open System.Text.RegularExpressions

let atbashMapping =
    [| 'a' .. 'z' |]
    |> fun a -> Array.zip a (Array.rev a)
    |> Map.ofArray

let atbashTransform =
    String.map
        (fun c ->
            match Map.tryFind c atbashMapping with
            | Some success -> success
            | None -> c)

let encode (str: string) =
    str.ToLower()
    |> fun s -> Regex.Replace(s, "[^a-z123]", "")
    |> atbashTransform
    |> Seq.chunkBySize 5
    |> Seq.map String.Concat
    |> fun s -> String.Join(' ', s)

let decode str =
    str
    |> fun s -> Regex.Replace(s, "\s", "")
    |> atbashTransform
