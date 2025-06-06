function sieve(limit)
    sieveNumbers = 2:limit
    for i in 2:limit
        sieveNumbers = filter(x -> !((x % i == 0) && (x >= 2 * i)), sieveNumbers)
    end
    sieveNumbers
end