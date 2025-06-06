function score(x, y)
    d = sqrt(x^2 + y^2)
    if d <= 1
        10
    elseif d <= 5
        5
    elseif d <= 10
        1
    else
        0
    end    
end
