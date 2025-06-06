function rotate(n, str::String)
    shifted_str = ""
    for c in str
        shifted_str = string(shifted_str, rotate(n, c))  
    end
    shifted_str
end

function rotate(n, c::Char)
    if isuppercase(c)
        (c - 'A' + n) % 26 + 'A'
    elseif islowercase(c)
        (c - 'a' + n) % 26 + 'a'
    else
        c
    end        
end