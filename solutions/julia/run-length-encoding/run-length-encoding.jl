using Pipe:@pipe

function encode(s::String)::String
    @pipe eachmatch(r"(.)\1*", s) |>
        Iterators.map(m -> m.match, _) |>
        collect |>
        map(s -> length(s) == 1 ? s[1] : string(length(s), s[1]), _) |>
        string(_...)
end

function decode(s::String)::String
    @pipe eachmatch(r"(\d*)([a-zA-Z\s])", s) |>
        Iterators.map(m -> isempty(m[1]) ? (1, m[2]) : (parse(Int, m[1]), m[2]), _) |>
        collect |>
        map(((n, c),) -> c^n, _) |>
        string(_...)       
end
