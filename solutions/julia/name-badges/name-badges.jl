function print_name_badge(id, name, department)
    (ismissing(id) ? "" : "[$id] - ") *
    name *
    " - " *
    (isnothing(department) ? "OWNER" : uppercase(department))
end

function salaries_no_id(ids, salaries)
    sum(salaries[ismissing.(ids)])
end
