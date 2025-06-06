ISBN = Union{String}
using Pipe:@pipe

function isvalid(_::DataType, str::ISBN)::Bool
    try
        if isnothing(match(r"^\d{1}-*\d{3}-*\d{5}-*[0-9X]{1}$", str))
            return false
        end
        @pipe replace(str, r"[^0-9X]" => "") |>
            collect |>
            map(c -> c == 'X' ? 10 : parse(Integer, c), _) |>
            _ .* collect(10:-1:1) |>
            sum |>
            _ % 11 |>
            ==(_, 0)
    catch
        throw(DomainError(str, "Invalid ISBN format"))
    finally
        false
    end
end

macro isbn_str(str::ISBN)
    if isvalid(ISBN, str)
        replace(str, r"[^0-9X]" => "")
    else
        throw(DomainError(str, "Invalid ISBN format"))
    end
end