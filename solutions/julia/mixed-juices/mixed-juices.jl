const juice_times = Dict(
    "Pure Strawberry Joy" => 0.5,
    "Energizer" => 1.5,
    "Green Garden" => 1.5,
    "Tropical Island" => 3.0,
    "All or Nothing" => 5.0
)

function time_to_mix_juice(juice)
    get(juice_times, juice, 2.5)
end

function wedges_from_lime(size)
    size == "small" ? 6 :
    size == "medium" ? 8 :
    10
end

function limes_to_cut(needed, limes)
    if isempty(limes) || needed <= 0
        0
    else
        next, rest... = limes
        1 + limes_to_cut(needed - wedges_from_lime(next), rest)
    end
end

function order_times(orders)
    map(time_to_mix_juice, orders)
end

function remaining_orders(time_left, orders)
    if isempty(orders) || time_left <= 0
        orders
    else
        next, rest... = orders
        remaining_orders(time_left - time_to_mix_juice(next), rest)
    end
end
