using Pipe: @pipe

function isisogram(s)
    s_clean = replace(s, r"[-\s]" => "")
    @pipe s_clean |>
        lowercase |>
        unique |>
        length |>
        (_ == length(s_clean))
end
