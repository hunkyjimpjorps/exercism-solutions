function transform(ch)
    ch == '-' ? "_" :
    isspace(ch) ? "" :
    isuppercase(ch) ? "-" * lowercase(ch) :
    isnumeric(ch) ? "" :
    ch ∈ 'α':'ω' ? "?" :
    string(ch)
end

function clean(str)
    join(transform.(collect(str)))
end
