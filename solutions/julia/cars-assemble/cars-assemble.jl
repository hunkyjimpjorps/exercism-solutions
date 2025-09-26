const base_rate = 221

function success_rate(speed)
    speed == 0 ? 0 :
    speed ∈ 1:4 ? 1.00 :
    speed ∈ 5:8 ? 0.90 :
    speed == 9 ? 0.80 :
    0.77
end

function production_rate_per_hour(speed)
    base_rate * speed * success_rate(speed)
end

function working_items_per_minute(speed)
    floor(Int, production_rate_per_hour(speed) / 60)
end
