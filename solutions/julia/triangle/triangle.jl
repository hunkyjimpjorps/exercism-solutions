using Match

function validtriangle(sides)
    @match(sides, [a, b, c])
    (a + b > c) && (a + c > b) && (b + c > a)
end

function is_equilateral(sides)
    @match(sides, [a, b, c])
    (a == b == c) && validtriangle(sides)
end

function is_isosceles(sides)
    @match(sides, [a, b, c])
    ((a == b) || (b == c) | (a == c)) && validtriangle(sides)
end

function is_scalene(sides)
    (!(is_isosceles(sides) || is_equilateral(sides))) && validtriangle(sides)
end
