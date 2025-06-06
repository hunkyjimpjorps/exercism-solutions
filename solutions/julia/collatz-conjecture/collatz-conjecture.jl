using MLStyle

@active IsInvalid(x) begin
    x <= 0 ? Some(x) : nothing
end

@active IsEven(x) begin
    iseven(x) ? Some(x) : nothing
end

function collatz_steps(n::Int, acc::Int=0)
    @match n begin
        IsInvalid(n) => throw(DomainError(n))
        1 => acc
        IsEven(n) => collatz_steps(n ÷ 2, acc + 1)
        _ => collatz_steps(3n + 1, acc + 1)
    end
end