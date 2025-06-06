using Pipe:@pipe
"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
function ispangram(input)
    @pipe input |>
        replace(_, r"[^A-Za-z]" => "") |>
        lowercase |>
        unique |>
        length |>
        ==(26, _)
end