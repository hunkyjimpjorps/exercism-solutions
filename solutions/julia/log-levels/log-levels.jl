function message(msg)
    parse(msg)[2]
end

function log_level(msg)
    lowercase(parse(msg)[1])
end

function reformat(msg)
    "$(message(msg)) ($(log_level(msg)))"
end

function parse(msg)
    match(r"\[(.*)\]:\s*(.*)", strip(msg)).captures
end