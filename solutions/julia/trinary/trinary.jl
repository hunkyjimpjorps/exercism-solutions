function trinary_to_decimal(str)
    if occursin(r"[^012]", str) return 0 end
    sum(map(((i, n),) -> 3^i * parse(Int, n), zip((0:length(str) - 1), str[end:-1:1])))
end