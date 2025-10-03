function matrix(strmatrix)
    array = parse.(Int, stack(split.(split(strmatrix, "\n"))))
    eachcol(array), eachrow(array)
end
