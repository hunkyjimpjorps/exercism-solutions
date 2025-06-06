using Pipe:@pipe

function all_your_base(digits, base_in, base_out)
    if base_in <= 1
        throw(DomainError(base_in))
    elseif base_out <= 1
        throw(DomainError(base_out))
    elseif !isnothing(findfirst(x -> x < 0 || x >= base_in, digits))
        throw(DomainError(digits))
    elseif isempty(digits)
        return([0])
    end

    base10 = @pipe digits |>
        reverse |>
        zip(_, Iterators.countfrom(0)) |>
        sum(((n, i),) -> n * base_in^i, _) |> 
        to_base_b(_, base_out, Int[]) |>
        (isempty(_) ? [0] : identity(_))
end

function to_base_b(n, b, acc)
    if n == 0
        acc
    else
        to_base_b(n ÷ b, b, insert!(acc, 1, n % b))
    end
end 
