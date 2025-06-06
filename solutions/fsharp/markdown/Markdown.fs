module Markdown

open System.Text.RegularExpressions

let (|IsHeaderLevel|_|) line =
    let re = Regex.Match(line, "^(#+)")

    match re.Value with
    | "" -> None
    | _ ->
        let n = re.Captures[0].Value.Length

        match n with
        | n when n > 6 -> None
        | _ -> Some(n, line.Remove(0, n + 1))

let (|IsListItem|_|) (line: string) =
    if line.StartsWith("* ") then
        Some(line.Remove(0, 2))
    else
        None

let formatStyle (markdown: string) =
    markdown
    |> fun m -> Regex.Replace(m, "(__|\*\*)(.*)(\1)", "<strong>$2</strong>")
    |> fun m -> Regex.Replace(m, "(_|\*)(.*)(\1)", "<em>$2</em>")

let parseLine (markdown: string) =
    match markdown with
    | IsHeaderLevel(n, rest) -> $"<h{n}>{formatStyle rest}</h{n}>"
    | IsListItem rest -> $"<li>{formatStyle rest}</li>"
    | _ -> $"<p>{formatStyle markdown}</p>"

let groupListItems (lines: string list) =
    let rec scanForListStart (lines: string list) =
        match lines with
        | [] -> []
        | first :: rest when first.StartsWith("<li>") -> "<ul>" :: first :: (scanForListEnd rest)
        | first :: rest -> first :: (scanForListStart rest)

    and scanForListEnd (lines: string list) =
        match lines with
        | [] -> ["</ul>"]
        | first :: rest when first.StartsWith("<li>") |> not -> "</ul>" :: first :: (scanForListStart rest)
        | first :: rest -> first :: (scanForListEnd rest)

    scanForListStart lines

let parse (markdown: string) =
    markdown.Split("\n")
    |> Array.map parseLine
    |> List.ofArray
    |> groupListItems
    |> String.concat ""