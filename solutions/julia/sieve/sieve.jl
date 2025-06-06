function sieve(limit)
    sieveNumbers = 2:limit
    for i in 2:isqrt(limit)
        sieveNumbers = filter(!in(collect(2i:i:limit)), sieveNumbers)
    end
    sieveNumbers
end