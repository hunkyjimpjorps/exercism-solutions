alphabet_length = length(collect('A':'Z'))

function rotate(n, str::String)
    if n % alphabet_length == 0 || isempty(str)
        return str 
    end

    shifted_str = ""
    for c in str
        shifted_str = string(shifted_str, rotate(n, c))  
    end
    shifted_str
end

function rotate(n, c::Char)
    if isuppercase(c)
        (c - 'A' + n) % alphabet_length + 'A'
    elseif islowercase(c)
        (c - 'a' + n) % alphabet_length + 'a'
    else
        c
    end        
end