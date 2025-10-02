import Dates

input_dateformat = dateformat"m/d/y H:M:S"
output_dateformat = dateformat"E, U d, Y at HH:MM"

function schedule_appointment(appointment::String)
    Dates.DateTime(appointment, input_dateformat)
end

function has_passed(appointment::DateTime)
    appointment < Dates.now()
end

function is_afternoon_appointment(appointment::DateTime)
    12 <= Dates.hour(appointment) < 18
end

function describe(appointment::DateTime)
    "You have an appointment on $(Dates.format(appointment, output_dateformat))"
end

function anniversary_date()
    Dates.Date(Dates.year(Dates.now()), 9, 15)
end
