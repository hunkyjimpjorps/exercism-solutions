using Pipe: @pipe

alphabet = 'a':'z'
cipher = Dict(zip(alphabet, reverse(alphabet)))

function encode(input)
    @pipe input |>
        lowercase |>
        replace(_, r"[^0-9a-z]" => "") |>
        map(c -> get(cipher, c, c), _) |>
        Iterators.partition(_, 5) |>
        collect |>
        map(String, _) |>
        join(_, " ")
end

function decode(input)
    @pipe input |>
        lowercase |>
        replace(_, r"[^0-9a-z]" => "") |>
        map(c -> get(cipher, c, c), _)
end

