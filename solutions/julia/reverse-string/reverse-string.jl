using Unicode
const TEST_GRAPHEMES = true

function myreverse(str::String)
    [c for c in Unicode.graphemes(str)] |> 
    reverse |>
    join
end