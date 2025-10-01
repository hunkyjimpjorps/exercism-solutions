function get_vector_of_wagons(args...)
    [args...]
end

function fix_vector_of_wagons(each_wagons_id, missing_wagons)
    wagon1, wagon2, locomotive, rest... = each_wagons_id
    [locomotive, missing_wagons..., rest..., wagon1, wagon2]
end

function add_missing_stops(route, stops...)
    merge(route, Dict("stops" => [v for (_, v) in stops]))
end

function extend_route_information(route; more_route_information...)
    merge(route, more_route_information)
end
