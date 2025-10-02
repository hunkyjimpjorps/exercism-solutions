function is_valid_command(msg)
    occursin(r"^Chatbot"i, msg)
end

function remove_emoji(msg)
    replace(msg, r"emoji\d+" => "")
end

function check_phone_number(number)
    if occursin(r"\(\+\d{2}\) \d{3}-\d{3}-\d{3}", number)
        "Thanks! You can now download me to your phone."
    else
        "Oops, it seems like I can't reach out to $(number)"
    end
end

function getURL(msg)
    [m.match for m in eachmatch(r"\b\w*\.\w*\b", msg)]
end

function nice_to_meet_you(str)
    "Nice to meet you, " * replace(str, r"(?<last>\w+), (?<first>\w+)" => s"\g<first> \g<last>")
end
