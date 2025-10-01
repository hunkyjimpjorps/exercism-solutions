function get_coordinate(line)
    line[2]
end

function convert_coordinate(coordinate)
    Tuple(coordinate)
end

function compare_records(azara_record, rui_record)
    _, azara_coord = azara_record
    _, rui_coord, _ = rui_record
    convert_coordinate(azara_coord) == rui_coord
end

function create_record(azara_record, rui_record)
    if compare_records(azara_record, rui_record)
        treasure, coord = azara_record
        location, _, quadrant = rui_record
        (coord, location, quadrant, treasure)
    else
        ()
    end
end
