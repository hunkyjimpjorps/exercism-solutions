"""
    is_leap_year(year)

Return `true` if `year` is a leap year in the gregorian calendar.

"""
function is_leap_year(year)
    if year % 400 == 0
        true
    elseif year % 100 == 0
        false
    elseif year % 4 == 0
        true
    else 
        false
    end
end

