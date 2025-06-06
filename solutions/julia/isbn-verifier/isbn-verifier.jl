using Pipe:@pipe

struct ISBN <: AbstractString
    number::String
    function ISBN(number)
        if isvalid(ISBN, number)
            replace(number, "-" => "") 
        else
            throw(DomainError(number, "Invalid ISBN-10 code"))
        end
    end
end

function isvalid(_::DataType, str::String)::Bool
    if isnothing(match(r"^\d{1}-*\d{3}-*\d{5}-*[0-9X]{1}$", str))
        return false
    end
    @pipe str |>
        replace(_, "-" => "") |>
        collect |>
        map(c -> c == 'X' ? 10 : parse(Integer, c), _) |>
        _ .* collect(10:-1:1) |>
        sum |>
        _ % 11 |>
        ==(_, 0)
end

macro isbn_str(str::String)
    ISBN(str)
end