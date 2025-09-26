function combinations_in_cage(cage_size, cage_count, omitted=[])
    combine(setdiff(1:9, omitted), cage_count) |> filter(xs -> sum(xs) == cage_size)
end

function combine(xs, len)
    if len == 0
        return [[]]
    elseif isempty(xs)
        return []
    else
        first, rest... = xs
        [map(n -> [first; n], combine(rest, len - 1)); combine(rest, len)]
    end
end