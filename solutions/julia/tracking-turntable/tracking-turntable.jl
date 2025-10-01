function z(x, y)
    complex(x, y)
end

function euler(r, θ)
    r * cis(θ)
end

function rotate(x, y, θ)
    reim(z(x, y) * cis(θ))
end

function rdisplace(x, y, dr)
    c = z(x, y)
    reim((abs(z(x, y)) + dr) * cis(angle(z(x, y))))
end

function findsong(x, y, r, θ)
    rdisplace(rotate(x, y, θ)..., r)
end
