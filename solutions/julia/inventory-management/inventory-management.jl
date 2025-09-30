function create_inventory(items)
    add_items(Dict(), items)
end

function add_items(inventory, items)
    for item in items
        inventory[item] = get(inventory, item, 0) + 1
    end
    return inventory
end

function decrement_items(inventory, items)
    for item in items
        if haskey(inventory, item)
            inventory[item] = max(get(inventory, item, 0) - 1, 0)
        end
    end
    return inventory
end

function remove_item(inventory, item)
    delete!(inventory, item)
end

function list_inventory(inventory)
    sort([p for p in inventory if !iszero(p[2])])
end
