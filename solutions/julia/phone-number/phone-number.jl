using Pipe: @pipe

function clean(phone_number)
    @pipe phone_number |>
    replace(_, r"[^0-9]" => "") |>
    match(r"^(1?)([2-9][0-9]{2}[2-9][0-9]{2}[0-9]{4})$", _) |>
    (if isnothing(_)
        return nothing
    else
        return _.captures[2]
    end)
end
