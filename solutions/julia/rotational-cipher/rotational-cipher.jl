function rotate(n, str::String)
    shifted_str = ""
    for c in str
        if isuppercase(Char(c))
            shifted_str = string(shifted_str, rotate(n, c))
        elseif islowercase(Char(c))
            shifted_str = string(shifted_str, rotate(n, c))
        else
            shifted_str = string(shifted_str, c)
        end        
    end
    shifted_str
end

function rotate(n, c::Char)
    if isuppercase(c)
        Char((Int(c) - Int('A') + n) % 26 + Int('A'))
    elseif islowercase(c)
        Char((Int(c) - Int('a') + n) % 26 + Int('a'))
    else
        c
    end        
end