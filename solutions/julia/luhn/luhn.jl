using Pipe: @pipe

function luhn(idNo)
    idNoNoSpaces = replace(idNo, " " => "")
    idNoCleaned = replace(idNoNoSpaces, r"[^0-9]" => "")
    
    if (idNoCleaned != idNoNoSpaces) || length(idNoNoSpaces) == 1
        return false
    end
    
    evenDigitSum = @pipe idNoCleaned |> 
        _[end-1 : -2 : 1] |>
        map(x -> 2 * parse(Int, x), collect(_)) |>
        map(x -> x > 9 ? x - 9 : x, _) |>
        sum(_)
    oddDigitSum = @pipe idNoCleaned |>
        _[end : -2 : 1] |>
        map(x -> parse(Int, x), collect(_)) |>
        sum(_)
    (evenDigitSum + oddDigitSum) % 10 == 0
end