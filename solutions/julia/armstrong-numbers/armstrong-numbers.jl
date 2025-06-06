function isarmstrong(n)
    n == sum(digits(n) .^ ndigits(n))
end