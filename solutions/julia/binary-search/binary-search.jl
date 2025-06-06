function binarysearch(arr, n; rev=false, by=identity, lt=(<))
    min = 1
    max = length(arr)
    arrBy = map(by, arr)
    nBy = by(n)

    function compare(i)
        lt(arrBy[i], nBy)
    end

    while min <= max
        global i = (max + min) ÷ 2
        if arrBy[i] == nBy
            return i:i
        elseif (rev ? !compare(i) : compare(i))
            min = i + 1
        else
            max = i - 1
        end
    end
    return i:(i - 1)
end