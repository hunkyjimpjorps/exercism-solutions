using Unicode

function myreverse(str::String)
    [c for c in Unicode.graphemes(str)] |> reverse
end