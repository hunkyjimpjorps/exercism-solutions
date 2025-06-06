function distance(a, b)
    if length(a) != length(b)
        ArgumentError("Strand lengths must match.") |> throw
    end
    (true for c = zip(a, b) if c[1] != c[2]) |> count
end
